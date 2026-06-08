# AI Chief of Staff — Foundation Setup Checklist (A1)

Eine Checkliste für das Setup des Dispatchers + zwei Sub-Workflows + Supabase. Arbeite sie von oben nach unten ab, die Reihenfolge zählt. Begleitend zur Ausgabe „Das Sequel-Skript" aus dem Newsletter [**die Blaumilch-Agenten** → adnanai.substack.com](https://adnanai.substack.com/?utm_campaign=pub&utm_medium=web).

## 0. Konten anlegen (in dieser Reihenfolge)

1. **n8n** — am schnellsten über das **n8n Cloud Starter-Paket** (von n8n selbst gehostet, ~24 €/Monat, 14-Tage-Probe, EU-Region wählbar). Nichts zu installieren, in Minuten startklar; auf n8n Cloud sind nur „verified" Community-Nodes erlaubt. Alternativ läuft n8n auch **lokal** auf deinem Rechner (`npx n8n` oder Docker, kostenlos) oder **selbst gehostet** auf einem eigenen Server, z.B. bei einem Anbieter wie Hetzner für ~5-15 €/Monat. Für den Einstieg ist n8n Cloud der direkteste Weg.
2. **Supabase** — Free Tier reicht für die Foundation. Wähle einen EU-Region (Frankfurt) für DSGVO-Komfort.
3. **Fireflies** — Pro-Plan oder höher (API-Zugang). Hol den API-Key in **Integrations → Fireflies API → Generate**.
4. **OpenAI** — API-Key mit Zugriff auf `gpt-4o-mini` (oder dein bevorzugtes Modell). Lade ein paar Euro auf, das System verbrennt wenig.
5. **Notion** — Plus-Tarif oder höher (10 €/User/Monat im Jahresvertrag). Webhook-Aktionen in Automationen brauchen ihn.

## 1. Env-Variablen (nur bei Self-Hosting)

Auf **n8n Cloud überspringst du diesen Schritt** — Hosting, HTTPS und den Encryption-Key übernimmt n8n für dich, weiter mit Schritt 2. Nur wenn du **selbst hostest** (lokal oder auf einem eigenen Server), gehören in deine `.env`-Datei:

```env
N8N_ENCRYPTION_KEY=<irgendein langer zufälliger String, z.B. `openssl rand -hex 32`>
N8N_HOST=n8n.deinedomain.de
N8N_PROTOCOL=https
WEBHOOK_URL=https://n8n.deinedomain.de
GENERIC_TIMEZONE=Europe/Berlin
DB_TYPE=sqlite   # oder postgres
```

> **Schmerzhafte Falle: `N8N_ENCRYPTION_KEY`.** Verlierst du diesen Schlüssel, sind alle gespeicherten Credentials unlesbar, selbst mit vollständigem DB-Backup. **Speichere ihn JETZT in deinem Passwort-Manager, getrennt vom Server.** Nicht später.

## 2. Supabase: Schema aufsetzen

In Supabase → **SQL Editor** → New Query → den Inhalt von `schema.sql` einfügen → **RUN**. Du bekommst zwei Tabellen: `runs` (Logbuch) und `coaching_history` (Gedächtnis). Beide haben Indexe.

Hol dir dann aus **Project Settings → API**:
- `Project URL` (z.B. `https://xyz.supabase.co`)
- `service_role` API Key (NICHT der `anon` Key — `service_role` hat Write-Zugriff)

## 3. n8n: Credentials anlegen

In n8n → **Credentials** → **Add Credential** für jede dieser drei:

| Credential-Name | Typ | Werte |
|---|---|---|
| `ACoS Dispatcher Secret` | Header Auth | Name: `x-acos-secret`, Wert: ein langer zufälliger String (`openssl rand -hex 16`). Den brauchst du gleich nochmal für den Notion-Button. |
| `Fireflies API` | Header Auth | Name: `Authorization`, Wert: `Bearer <dein Fireflies API Key>` |
| `Supabase` | Supabase | Host: `https://xyz.supabase.co`, Service Role Secret: dein `service_role` Key |
| `OpenAI` | OpenAI | API Key: dein OpenAI key |

## 4. n8n: Workflows importieren (Reihenfolge entscheidend)

**Erst die zwei Sub-Workflows, dann den Dispatcher.** Sonst sind die Workflow-IDs noch nicht bekannt.

1. **Workflows → Add workflow → From file** → `ProFollowUp_TEMPLATE.json` auswählen.
   - Öffne den `OpenAI Chat Model`-Node, weise dein OpenAI-Credential zu.
   - Öffne `Draft Follow-up`, ersetze den `{{REPLACE_ME_FOLLOWUP_SYSTEM_PROMPT}}`-Block mit deinem eigenen System-Prompt (Name, Firma, 2-3 Beispiele deiner besten Follow-ups).
   - Speichern, dann **Activate** oben rechts.
   - **Notiere die Workflow-ID** aus der URL (`/workflow/<ID>`).

2. **Add workflow → From file** → `CoachingAdvice_TEMPLATE.json`.
   - Weise dem `OpenAI Chat Model` dein OpenAI-Credential zu.
   - Weise `Read Coaching History` und `Insert Coaching Row` dein Supabase-Credential zu.
   - Öffne `Generate Coaching Note`, ersetze den `{{REPLACE_ME_COACHING_SYSTEM_PROMPT}}`-Block.
   - Speichern, **Activate**.
   - **Notiere die Workflow-ID**.

3. **Add workflow → From file** → `Dispatcher_TEMPLATE.json`.
   - **Webhook**-Node: weise das `ACoS Dispatcher Secret` Header-Auth-Credential zu.
   - **Fetch Transcript**: weise das Fireflies Header-Auth-Credential zu.
   - **Insert Runs Row, Update Runs Row, Insert Failed Run, Mark Run Failed**: alle vier kriegen das Supabase-Credential.
   - **Validate & Init** (Edit Fields-Node, kein Code mehr): im `tenant_id`-Feld ersetze `{{REPLACE_ME_TENANT_ID}}` mit einer UUID v4. Erzeuge eine mit `uuidgen` auf macOS/Linux oder einem Online-UUID-v4-Generator. Beispiel: `4a9324b2-5a79-4f7a-8b16-3928ad7e08f1`. Diese eine UUID ist dein Tenant. Speichere sie, du brauchst sie später für multi-tenant Migration.
   - **Run Pro FollowUp**: ersetze `{{REPLACE_ME_PRO_FOLLOWUP_WORKFLOW_ID}}` mit der ID aus Schritt 1.
   - **Run Coaching Advice**: ersetze `{{REPLACE_ME_COACHING_ADVICE_WORKFLOW_ID}}` mit der ID aus Schritt 2.
   - Speichern, **Activate**.

## 5. Notion: Trigger-Datenbank aufsetzen

Deine Fireflies-Integration in Notion legt nach jedem Meeting eine Seite in einer Datenbank an (du verbindest sie in **Fireflies → Settings → Integrations → Notion**). In dieser Datenbank ergänzt du:

- **Eine Select-Spalte `Action`** mit den Optionen `Pro FollowUp` und `Coaching Advice`.
- **Einen Button-Knopf** in einer Button-Spalte, der per **Automation → Send webhook** an deinen Dispatcher-Webhook ruft.

Der Webhook-Aufruf braucht:
- **URL**: deine Dispatcher-Webhook-URL (in n8n auf dem Webhook-Node sichtbar als "Production URL").
- **Method**: POST
- **Header**: `x-acos-secret: <dein dispatcher secret>` (derselbe String wie in Schritt 3)
- **Body** (JSON):
  ```json
  {
    "meeting_id": "{{Fireflies Meeting ID property}}",
    "action": "{{lowercase und unterscore: pro_followup oder coaching_advice}}"
  }
  ```

> **Tipp:** mappe den Select-Wert auf den Workflow-Wert mit einer Formel-Spalte: `if(prop("Action") == "Pro FollowUp", "pro_followup", "coaching_advice")`. Den Formel-Wert referenziert dann der Button.

## 6. Test-Lauf

1. Öffne in Notion eine Zeile mit einem echten Fireflies-Meeting.
2. Wähle in `Action` z.B. `Pro FollowUp`.
3. Klicke den Button.
4. In n8n → **Executions** solltest du innerhalb von 30 Sekunden einen `success`-Lauf sehen.
5. In Supabase → **Table editor → runs** → siehst du eine neue Zeile mit `status=success` und `output` als Follow-up-Text.

Wenn etwas schiefläuft: schau in `runs.status='failed'` + `runs.error` für die Fehlermeldung.

## 7. Häufige Stolpersteine

- **"Action sub-workflow failed"** beim ersten Lauf. Ursache: einer der Sub-Workflows ist nicht aktiv. n8n's `Execute Workflow` Node kann inaktive Sub-Workflows nicht rufen. **Aktiviere alle drei Workflows.**
- **403 vom Dispatcher.** Header-Auth-Wert stimmt nicht. Vergleiche den `x-acos-secret`-Wert im Credential mit dem im Notion-Button.
- **Polling-Trigger.** Du brauchst keinen. Bei diesem Setup ruft Notion → Dispatcher per Webhook. Ein 5-Min-Polling-Trigger würde 8.640 Executions/Monat verbrennen.
- **`gen_random_uuid()` not found.** Die `pgcrypto`-Extension ist nicht aktiv. Das `schema.sql` aktiviert sie — wenn du etwas anderes laufen lässt, führe vorher `create extension if not exists "pgcrypto";` aus.

## 8. Was als nächstes?

Mehr Sub-Workflows: einfach einen neuen `_TEMPLATE`-Stil-Workflow bauen, im Dispatcher einen Switch-Case ergänzen, in Notion einen neuen Action-Wert. Den Dispatcher fasst du nicht an. In A2 dieser Reihe: Draft Proposal + ein Task Creator, der die Action-Items in deine To-Do-Schaltzentrale schreibt.

::: cta
**Diese Anleitung ist Teil der AI-Chief-of-Staff-Reihe im Newsletter „die Blaumilch-Agenten".**

Jede Ausgabe baut ein Stück weiter: Task Creator, Draft Proposal, die localhost-App, Multi-Tenant. Wenn dir dieses Setup etwas gebracht hat, abonniere und bleib dabei.

→ **[adnanai.substack.com](https://adnanai.substack.com/?utm_campaign=pub&utm_medium=web)**
:::
