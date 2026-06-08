# AI Chief of Staff — Task Creator Setup Checklist (A2)

Eine Checkliste, um den **Task Creator** zu deiner bestehenden AI-Chief-of-Staff-Foundation hinzuzufügen: er zieht die Action-Items aus dem Meeting-Transkript und legt sie als echte Aufgaben in deiner Notion-Tabelle an, verlinkt zurück aufs Meeting. Sie setzt voraus, dass der Dispatcher, die Sub-Workflows und Supabase aus der A1-Ausgabe schon laufen. Begleitend zum Newsletter [**die Blaumilch-Agenten** → adnanai.substack.com](https://adnanai.substack.com/?utm_campaign=pub&utm_medium=web).

> **Neuer Build, kein Umbau.** Eine neue Fähigkeit ist ein neuer Sub-Workflow plus ein Switch-Case im Dispatcher. Neu hier: der Dispatcher reicht zusätzlich die Notion-Seiten-ID des Meetings mit durch, damit jede Aufgabe aufs Meeting verlinkt.

## 0. Voraussetzung

Die A1-Foundation steht: Dispatcher (`Dispatcher_TEMPLATE`), die `runs`-Tabelle in Supabase, das `ACoS Dispatcher Secret` und dein OpenAI-Credential in n8n. Task Creator braucht **keine neue Supabase-Tabelle**: das Logging läuft über den Dispatcher in `runs`.

## 1. Notion vorbereiten (Tabelle + Integration)

1. **Eine Aufgaben-Tabelle in Notion**, die eine **Relation** zu deiner Meetings-Datenbank hat. Empfohlene Properties: ein Titel (`Activity Title`), `Status` (Status-Typ), `Priority` (Select: High/Medium/Low), `Owner` (Person), `Action Items` (Text), `Due Date` (Datum), und die `Meeting`-Relation zurück zur Meetings-DB. Du kannst eine bestehende Tabelle nehmen, sie muss nur die Relation haben.
2. **Eine interne Notion-Integration** (Notion → Settings → Connections → Develop or manage integrations → New integration). Capabilities: **Insert content + Update content + Read content**, und **Read user information including email** (das brauchst du, damit `Owner` als Person gesetzt werden kann).
3. **Verbinde die Integration mit beiden Datenbanken**: der Aufgaben-Tabelle UND der Meetings-DB (••• → Connections). Ohne Zugriff auf die Meetings-DB schlägt die Relation fehl.
4. In n8n → **Credentials → Add → Notion API** → das Integration-Secret einfügen.

## 2. Sub-Workflow importieren + konfigurieren

1. **Workflows → Add workflow → From file** → `TaskCreator_TEMPLATE.json`.
2. `OpenAI Chat Model`-Node: dein OpenAI-Credential zuweisen.
3. `Create Task Page`-Node (HTTP Request): dein **Notion API**-Credential zuweisen.
4. `Parse Tasks`-Node (Code): oben die `{{REPLACE_ME_...}}`-Werte setzen:
   - `DB_ID` = die ID deiner Aufgaben-Tabelle (32 Hex-Zeichen aus der DB-URL).
   - `OWNER_MAP` = Vorname (lowercase) → Notion-User-ID. User-IDs holst du per `GET https://api.notion.com/v1/users` (mit deinem Integration-Token). Leer lassen ist ok.
   - `DEFAULT_OWNER` = die User-ID, auf die unzugeordnete Aufgaben fallen (z.B. du selbst).
   - **Property-Namen** im `props`-Objekt (`Activity Title`, `Status`, `Priority`, `Owner`, `Action Items`, `Due Date`, `Meeting`) **exakt** an die Spalten deiner Tabelle anpassen.
5. Speichern, **Activate**. **Workflow-ID** aus der URL notieren (`/workflow/<ID>`).

## 3. Dispatcher erweitern (vier Eingriffe)

1. **`Validate & Init`** (Edit Fields-Node, kein Code mehr): ergänze `task_creator` im Array des `valid`-Feldes (dort stehen schon `pro_followup` und `coaching_advice`), und füge ein neues Feld `notion_page_id` hinzu mit Wert `={{ $json.body?.notion_page_id ?? $json.notion_page_id }}` (neben `meeting_id` und `action`).
2. **`Prepare Sub-WF Input`**: `notion_page_id` ins Objekt aufnehmen, das an den Sub-Workflow geht (Quelle: `Validate & Init`).
3. **`Route by Action`** (Switch): einen Ausgang für `task_creator`.
4. **Neuer `Run Task Creator`-Node** (Execute Workflow): Workflow-ID aus Schritt 2.5, `onError` = `continueErrorOutput`, verkabelt an `Update Runs Row` (Erfolg) und `Mark Run Failed` (Fehler).

Webhook und Secret-Logik bleiben unangetastet.

## 4. Notion: Trigger ergänzen

In deiner Trigger-Datenbank (die mit dem Fireflies-Meeting): ergänze in der Action-/Trigger-Spalte den Wert **`Task Creator`** (Mapping auf `task_creator`). Der Button schickt mit `x-acos-secret`-Header:

```json
{
  "meeting_id": "{{Fireflies Meeting ID}}",
  "action": "task_creator",
  "notion_page_id": "{{ID dieser Notion-Seite}}"
}
```

Die `notion_page_id` ist die ID der Meeting-Seite selbst (der Notion-Button kennt sie). Sie setzt später die Relation der Aufgabe zurück aufs Meeting.

## 5. Test-Lauf

1. Öffne in Notion eine Zeile mit einem echten Fireflies-Meeting (mit klaren To-dos im Transkript).
2. Wähle `Task Creator`, klicke den Button.
3. In n8n → **Executions**: ein `success`-Lauf in ~Sekunden.
4. In deiner Aufgaben-Tabelle: eine Zeile pro Action-Item, mit Owner, Priorität und der `Meeting`-Relation zurück aufs Gespräch.
5. In Supabase → **runs**: eine neue Zeile mit `status=success` und der Zusammenfassung in `output`.

## 6. Häufige Stolpersteine

- **404 auf der Webhook-Produktions-URL**, wenn du Sub-Workflow-Webhooks per API anlegst. Lege den Webhook über die UI an oder setze eine explizite `webhookId`. Bei Import über die UI passiert das automatisch.
- **Notion 400 / „property does not exist".** Die Property-Namen im `Parse Tasks`-Node stimmen nicht 1:1 mit deiner Tabelle überein. Genau abgleichen, inkl. Groß-/Kleinschreibung.
- **Owner bleibt leer oder falsch.** Namensabgleich ist wackelig. Sagt das Transkript „Adi" statt „Adnan", greift `DEFAULT_OWNER`. Halte `OWNER_MAP` klein und prüf die Zuordnungen einmal pro Woche.
- **Relation wird nicht gesetzt.** Die Integration hat keinen Zugriff auf die Meetings-DB, oder die `notion_page_id` fehlt im Dispatcher-Payload. Beides oben in Schritt 1.3 / 3.1-3.2.
- **Aufgaben werden erfunden.** Schärfe im `Extract Tasks`-Prompt die Regel „nur echte Commitments, sonst leeres Array".

## 7. Was als nächstes?

Dasselbe Muster trägt jede weitere Fähigkeit: neuer `_TEMPLATE`-Sub-Workflow, ein Switch-Case, ein Notion-Action-Wert. Das **Draft Proposal** (eigenes Bundle) erzeugt aus demselben Gespräch einen ersten Angebotsentwurf.

::: cta
**Diese Anleitung ist Teil der AI-Chief-of-Staff-Reihe im Newsletter „die Blaumilch-Agenten".**

Jede Ausgabe baut ein Stück weiter: das Gedächtnis, der Task Creator, das Draft Proposal, die localhost-App, Multi-Tenant. Wenn dir das etwas bringt, abonniere und bleib dabei.

→ **[adnanai.substack.com](https://adnanai.substack.com/?utm_campaign=pub&utm_medium=web)**
:::
