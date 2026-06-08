# AI Chief of Staff — Draft Proposal Setup Checklist (A2.5)

Eine kurze Checkliste, um den **Draft Proposal**-Sub-Workflow zu deiner bestehenden AI-Chief-of-Staff-Foundation hinzuzufügen. Sie setzt voraus, dass der Dispatcher, die Sub-Workflows und Supabase aus der A1-Ausgabe schon laufen. Begleitend zum Newsletter [**die Blaumilch-Agenten** → adnanai.substack.com](https://adnanai.substack.com/?utm_campaign=pub&utm_medium=web).

> **Neuer Build, kein Umbau.** Das ist die Regel der ganzen Reihe: Eine neue Fähigkeit ist ein neuer Sub-Workflow plus ein Switch-Case im Dispatcher. Den Kern des Dispatchers fasst du nicht an.

## 0. Voraussetzung

Die A1-Foundation steht: Dispatcher (`Dispatcher_TEMPLATE`), mindestens ein Sub-Workflow, die `runs`-Tabelle in Supabase, das `ACoS Dispatcher Secret` und dein OpenAI-Credential in n8n. Draft Proposal braucht **keine neue Tabelle**: das Logging läuft über den Dispatcher in `runs`, genau wie bei Pro FollowUp.

## 1. Sub-Workflow importieren

1. **Workflows → Add workflow → From file** → `DraftProposal_TEMPLATE.json` auswählen.
2. Öffne den `OpenAI Chat Model`-Node, weise dein OpenAI-Credential zu.
3. Öffne `Draft Proposal`, ersetze den `{{REPLACE_ME_PROPOSAL_SYSTEM_PROMPT}}`-Block mit deinem eigenen System-Prompt: Name, Firma, die Leistungen, die du wirklich anbietest, deine Preisregeln, deine No-Gos. Häng 1-2 echte, frühere Angebote als Stil-Anker an.
4. Speichern, dann **Activate** oben rechts.
5. **Notiere die Workflow-ID** aus der URL (`/workflow/<ID>`).

## 2. Dispatcher erweitern (drei kleine Eingriffe)

1. **`Validate & Init`** (Edit Fields-Node, kein Code mehr): ergänze `draft_proposal` im Array des `valid`-Feldes (dort, wo schon `pro_followup` und `coaching_advice` stehen).
2. **`Route by Action`** (Switch-Node): füge einen Ausgang für den Wert `draft_proposal` hinzu.
3. **Neuer `Run Draft Proposal`-Node** (Execute Workflow): Workflow-ID aus Schritt 1.5 eintragen, `onError` auf `continueErrorOutput`, und wie die anderen Sub-Workflow-Nodes an `Update Runs Row` (Erfolg) und `Mark Run Failed` (Fehler) verkabeln.

Speichern. Den Dispatcher-Webhook und die Secret-Logik lässt du unangetastet.

## 3. Notion: Action-Wert ergänzen

In deiner Trigger-Datenbank (die mit dem Fireflies-Meeting): ergänze in der Action-Spalte den Wert **`Draft Proposal`** und im Button-/Formel-Mapping den Workflow-Wert `draft_proposal`. Der Button schickt dann wie gewohnt `{ "meeting_id": "...", "action": "draft_proposal" }` mit dem `x-acos-secret`-Header an deinen Dispatcher.

## 4. Test-Lauf

1. Öffne in Notion eine Zeile mit einem echten Fireflies-Meeting, in dem es um Scope/Bedarf ging.
2. Wähle in der Action-Spalte `Draft Proposal`.
3. Klicke den Button.
4. In n8n → **Executions** siehst du innerhalb von ~30 Sekunden einen `success`-Lauf.
5. In Supabase → **runs** → eine neue Zeile mit `status=success` und dem Markdown-Angebot in `output`.

## 5. Häufige Stolpersteine

- **"Action sub-workflow failed"** beim ersten Lauf. Der Sub-Workflow ist nicht aktiv. n8n's `Execute Workflow` kann inaktive Sub-Workflows nicht rufen. **Aktiviere den Workflow** (der `Webhook (test)`-Trigger hält ihn aktiv, deshalb bleibt er drin).
- **Action wird abgewiesen.** `draft_proposal` fehlt im Array des `valid`-Feldes der `Validate & Init` Node. Genau gleich schreiben wie im Notion-Mapping.
- **Das Angebot erfindet Preise.** Dein System-Prompt ist zu offen. Schärfe die Regel „erfinde keine Preise oder Zusagen, die nicht im Transkript stehen, sonst [TBD]" und gib echte Beispiele.

## 6. Was als nächstes?

Dasselbe Muster trägt jede weitere Fähigkeit: neuer `_TEMPLATE`-Sub-Workflow, ein Switch-Case, ein Notion-Action-Wert. In „Der letzte Meter" baust du den **Task Creator**, der die Action-Items aus dem Meeting als echte Aufgaben in deine bestehende Tabelle schreibt.

::: cta
**Diese Anleitung ist Teil der AI-Chief-of-Staff-Reihe im Newsletter „die Blaumilch-Agenten".**

Jede Ausgabe baut ein Stück weiter: das Gedächtnis, der Task Creator, das Draft Proposal, die localhost-App, Multi-Tenant. Wenn dir das etwas bringt, abonniere und bleib dabei.

→ **[adnanai.substack.com](https://adnanai.substack.com/?utm_campaign=pub&utm_medium=web)**
:::
