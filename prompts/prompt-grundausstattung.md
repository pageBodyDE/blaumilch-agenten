# Die Prompt-Grundausstattung

*Fünf Griffe, die jede KI-Anfrage besser machen, plus ein Werkzeugkasten fertiger Vorlagen zum Kopieren.*

> **Kostenlos aus der Blaumilch-Werkstatt.** Die Ausgabe auf Substack: https://blaumilch.substack.com/p/prompt-grundausstattung
>
> Teil der Reihe **Besser prompten**: [Sammlung](besser-prompten.md) · [Grundausstattung](prompt-grundausstattung.md) · [Frameworks](prompt-frameworks.md) · [Techniken](prompt-techniken.md)
>
> Mehr von den Blaumilch-Agenten: https://github.com/pageBodyDE/blaumilch-agenten · https://blaumilch.substack.com

---

## Einleitung

Die meisten reden über KI wie über einen Promi. Wer hat was Neues gesagt, wer hat wen überholt. Dabei steht das Ding eher wie ein Werkzeug in der Ecke und wartet, dass es mal jemand in die Hand nimmt.

Ich hab lange gebraucht, bis ich es kapiert hab: Es liegt selten an der KI. Es liegt daran, wie ich frage. Eine nackte Frage gibt eine nackte Antwort. Ein bisschen Kontext, eine Rolle, eine klare Form, und auf einmal ist das Ding zu was zu gebrauchen.

Dieses Heft hat zwei Teile. Zuerst das Framework: fünf Griffe, die jede Anfrage besser machen, egal mit welchem Tool du arbeitest. Danach ein Werkzeugkasten fertiger Vorlagen, viele zum direkten Kopieren, für Vertrieb, Marketing und den täglichen Betrieb. Ein paar davon sind kleine Ketten: ein Prompt, dann der nächste, der auf dem Ergebnis aufbaut.

Fang mit einem an. Das Zeug verzinst sich. Versprochen.

## Das Framework · Die fünf Griffe

1. **Sag ihm, wer er ist und für wen.** Gib dem Assistenten zuerst eine Rolle und sag ihm, für wen das Ganze ist. Kostet einen Satz, ändert alles. Statt „Schreib eine Absage an einen Bewerber" lieber „Du bist eine erfahrene Personalerin im Mittelstand. Schreib eine freundliche, klare Absage an jemanden, den wir sympathisch fanden, aber nicht nehmen."
2. **Gib ihm den Kontext, den du im Kopf hast.** Die KI weiß nichts über deine Firma, deinen Kunden, dein Ziel. Was bei dir selbstverständlich ist, schreib es einmal hin. Das ist der Unterschied zwischen brauchbar und beliebig.
3. **Gib die Form vor.** Sag, wie das Ergebnis aussehen soll und in welchem Ton. Statt „Fass das zusammen" lieber „Fass das in drei Sätzen zusammen, sachlich, ohne Füllwörter."
4. **Zeig ein Beispiel.** Wenn es auf den Stil ankommt, gib ein Muster mit. Häng eine alte, gelungene Mail an und schreib: in diesem Ton. Ein gutes Beispiel sagt mehr als drei Sätze Erklärung.
5. **Schärf nach, statt neu anzufangen.** Die erste Antwort ist ein Entwurf, kein Urteil. Sag, was fehlt, statt von vorne zu prompten. Und lass es dir ruhig auch mal selbst Fragen stellen.

Diese fünf Griffe stecken in jeder Vorlage, die jetzt kommt. Wer sie einmal sieht, baut sich den Rest selbst.

## Das Framework · Für Fortgeschrittene

**Lass dir den Prompt bauen, statt ihn zu tüfteln.** Du musst nicht jeden Prompt selbst basteln. Es gibt Werkzeuge, die aus einer groben Idee einen sauberen, ausführlichen Prompt machen. Gut, wenn dir die Worte fehlen oder es schnell gehen muss.

**Der Trick, der nichts kostet: lass die KI nachfragen.** Bevor die KI loslegt, bitte sie um Rückfragen. Ein Satz reicht.

```
Bevor du antwortest: Stell mir drei kurze Fragen, mit denen deine Antwort
deutlich besser wird. Erst danach legst du los.
```

Der Dreh: Auf einmal denkt das Ding mit, statt zu raten. Klappt mit jedem Tool.

**Oder lass die KI ihren eigenen Prompt schärfen.** Gib einen groben Prompt und lass ihn erst verbessern, bevor er ausgeführt wird.

```
Hier ist mein Prompt: [DEIN PROMPT].
Mach ihn präziser und vollständiger, zeig mir die bessere Version,
und führ sie dann aus.
```

**Die Regler: im Chatfenster gibt es sie nicht.** Jedes Modell hat unter der Oberfläche ein paar Regler. Die siehst du im normalen Chat aber nicht. Sie sitzen in der API, im Playground (OpenAI) oder der Console (Anthropic), und in manchen Tools. Für 90 Prozent des Alltags reichen die fünf Griffe.

- **Temperatur**: nüchtern oder einfallsreich. Niedrig (etwa 0.2) gibt konsistente, sachliche Antworten, gut für Fakten und Vorlagen. Höher (etwa 0.8) wird einfallsreicher, aber weniger berechenbar, gut fürs Brainstorming.
- **Maximale Länge**: deckelt, wie lang die Antwort werden darf (in der API: max tokens). Praktisch, wenn du knappe Ausgaben erzwingen willst.
- **Top-p**: eine zweite Art, die Vielfalt zu steuern. Faustregel: dreh an der Temperatur ODER an Top-p, nicht an beiden gleichzeitig.

Merksatz: Regler sind Feintuning, kein Ersatz für einen guten Prompt. Erst die fünf Griffe, dann die Regler.

## Vorlagen · Vertrieb

**Die kalte Erstansprache.** Der erste Kontakt zu jemandem, der dich nicht kennt. Kurz, konkret, mit einem Anlass.

```
Schreib mir eine kurze Erstansprache (höchstens 80 Wörter) an [Person, Rolle, Firma].
Anlass: [z.B. sie haben gerade einen neuen Standort eröffnet]
- ein konkreter Bezug auf den Anlass
- ein Satz, was wir für Firmen wie ihre tun
- eine klare, einfache Frage am Schluss
Ton: direkt, selbstbewusst, kein Verkäufer-Sprech.
```

Der Dreh: Der Anlass macht aus Spam eine Nachricht. Ohne ihn löscht es jeder.

**Auf einen Einwand reagieren.** Zu teuer, keine Zeit, müssen wir intern besprechen. Wenn dir die ruhige Antwort fehlt.

```
Ein Kunde sagt: [z.B. das ist mir zu teuer].
Gib mir drei mögliche Antworten:
- jede aus einem anderen Winkel
- ruhig und ehrlich, kein Druck
- beim Preis: rechne den Nutzen und die Kosten des Nichtstuns vor
Kontext: [was wir anbieten, für wen].
```

Der Dreh: Drei Winkel, nicht eine Antwort. Den passenden wählst du selbst.

**Aus Merkmalen einen Nutzen machen.** Für den Shop, das Angebot, die Website.

```
Schreib einen kurzen Text für [Produkt oder Leistung]. Mach aus jedem Merkmal
einen Nutzen für den Kunden.
Merkmale:
- [Merkmal 1]
- [Merkmal 2]
Zielgruppe: [wer]. Ton: [z.B. sachlich, warm].
```

Der Dreh: Merkmal ist aus Edelstahl. Nutzen ist hält ein Leben lang. Sag ihm, er soll übersetzen.

**Die Discovery vorbereiten.** Das wichtige Gespräch. Zwei Prompts: erst verstehen, dann die richtigen Fragen.

*1 · Erst den Kunden verstehen.*

```
Ich habe gleich ein Gespräch mit [Person, Rolle, Firma, Branche].
Fass für mich zusammen:
- was so ein Unternehmen wahrscheinlich umtreibt
- drei Probleme, bei denen wir helfen könnten
- worauf ich im Gespräch achten sollte
Wenn dir Infos fehlen, sag welche.
```

*2 · Dann die Fragen, die das Gespräch tragen.*

```
Auf Basis davon: gib mir sieben offene Fragen fürs Gespräch.
- vom Allgemeinen zum Konkreten
- keine, die man mit ja/nein abwürgen kann
- am Ende zwei Fragen, die auf ein konkretes Angebot hinführen.
```

Der Dreh: Die zweite Frage baut auf der ersten Antwort auf. Genau so kettest du Prompts.

**Die Follow-up-Sequenz.** Nach einem guten Termin nicht im Sande verlaufen. Drei Nachrichten über zwei, drei Wochen.

*1 · Direkt nach dem Termin.*

```
Schreib eine kurze Mail nach einem guten Gespräch:
- bezieht sich auf einen konkreten Punkt von heute
- fasst in einem Satz zusammen, was wir anbieten
- schlägt einen klaren nächsten Schritt vor
Worüber wir geredet haben: [STICHPUNKTE].
```

*2 · Eine Woche später, wenn Stille ist.*

```
Noch keine Antwort. Schreib einen freundlichen Anstupser:
- ohne Druck, ohne Vorwurf
- gib etwas Nützliches mit (ein Gedanke, ein Beispiel, eine Zahl)
- halt es unter fünf Sätzen.
```

*3 · Der letzte, höfliche Anstupser.*

```
Immer noch nichts. Schreib eine kurze Schluss-Mail:
- nimm den Druck raus („ich hake das Thema sonst ab")
- lass die Tür offen
- ein, zwei Sätze, keine Wand aus Text.
```

Der Dreh: Jede Nachricht baut auf der vorigen auf und gibt, statt zu fordern. Das ist die ganze Kunst.

## Vorlagen · Marketing

**Dein Produkt positionieren.** Wenn alle das Gleiche behaupten und du anders klingen willst. Drei Schritte vom Markt zur fertigen Botschaft.

*1 · Erst die Konkurrenz sortieren.*

```
Du bist Positionierungs-Stratege. Hier sind drei, vier Wettbewerber: [LISTE].
Fass zusammen, mit welchem Versprechen jeder auftritt, und zeig mir, wo eine
Lücke ist, die keiner besetzt.
```

*2 · Dann den eigenen Winkel schärfen.*

```
Auf Basis dieser Lücke: formulier mir drei mögliche Positionierungen für
[Produkt/Leistung], jede in einem Satz. Für wen, wogegen, warum anders.
```

*3 · Aus dem Winkel echte Worte machen.*

```
Nimm Positionierung [Nr.]. Schreib daraus:
- eine Kernbotschaft in einem Satz
- drei Nutzen-Punkte
- einen Aufhänger für die Startseite
Ton: [z.B. klar, warm, kein Marketing-Sprech].
```

Der Dreh: Erst der Markt, dann der Winkel, dann die Worte. Wer mit den Worten anfängt, klingt wie alle.

**Verstehen, was die Zielgruppe antreibt.** Bevor du textest. Was bewegt die Leute wirklich zum Kauf.

```
Zielgruppe: [wer]. Produkt: [was].
Nenn mir die wichtigsten Gründe und Auslöser, warum so jemand kauft, und die
größten Bedenken, die ihn abhalten. Sortier nach Wichtigkeit.
```

Der Dreh: Die Bedenken sind Gold. Genau die räumst du im Text aus.

**Launch-Text, der den ersten Satz nicht verschenkt.** Neue Leistung, neues Produkt, eine Ankündigung, die hängen bleibt.

```
Schreib einen kurzen Ankündigungs-Text für [Produkt/Leistung].
- erster Satz: ein Haken, kein Aufwärmen
- ein klares Versprechen (was hat der Leser davon)
- ein Grund, jetzt zu handeln
Zielgruppe: [wer]. Ton: [z.B. selbstbewusst, nahbar].
```

Der Dreh: Lass dir drei verschiedene erste Sätze geben. Der erste Satz entscheidet, ob der Rest gelesen wird.

**Aus einem Gedanken einen Social-Post.** Du hast eine Beobachtung, willst aber nicht bei null anfangen. Erst Rohmaterial, dann Feinschliff.

*1 · Erst Varianten erzeugen.*

```
Hier ist mein roher Gedanke: [GEDANKE].
Gib mir fünf verschiedene Aufhänger dafür, je eine Zeile, je ein anderer Blickwinkel.
```

*2 · Dann den besten ausbauen.*

```
Nimm Aufhänger [Nr.]. Bau daraus einen kurzen Post:
- der Aufhänger als erste Zeile
- drei, vier kurze Absätze
- ein Schluss, der eine Reaktion einlädt
Schreib, wie ein Mensch redet, nicht wie eine Broschüre.
```

Der Dreh: Erst breit (fünf Winkel), dann tief (einer ausgebaut). Das trennt die Ideen vom Schreiben.

## Vorlagen · Produktivität & Organisation

**Aus dem Notiz-Chaos eine saubere Zusammenfassung.** Nach jedem Meeting, wenn du halbe Stichworte hast und keine Lust, das nochmal sauber zu tippen.

```
Hier sind meine rohen Meeting-Notizen. Mach mir daraus:
1. eine Zusammenfassung in drei Sätzen
2. eine Liste der Entscheidungen
3. eine Liste der offenen To-dos mit (falls genannt) wer und bis wann
Schreib sachlich, keine Füllwörter. Hier die Notizen:
[DEINE NOTIZEN]
```

Der Dreh: Du gibst die drei Blöcke vor. Wer fass mal zusammen sagt, kriegt Brei.

**Langes Dokument, die drei Kernpunkte.** Der zwölfseitige Vertrag, das lange Protokoll, die Mail von ganz oben.

```
Lies den folgenden Text und gib mir:
1. die drei wichtigsten Punkte in je einem Satz
2. was das konkret für mich bedeutet
3. was ich jetzt tun oder entscheiden muss
Hier der Text:
[TEXT EINFÜGEN]
```

Der Dreh: Punkt 2 und 3 sind der eigentliche Wert. Nicht nur zusammenfassen, sondern übersetzen, was es für DICH heißt.

**Eine wirre Aufgaben-Liste sortieren.** Zwanzig Dinge im Kopf, kein Plan, womit anfangen.

```
Hier ist meine Aufgaben-Liste, ungeordnet. Sortier sie für mich:
- nach Wichtigkeit und Dringlichkeit
- markiere, was heute wirklich muss
- nenne eine Sache, die ich wahrscheinlich abgeben oder streichen kann
Hier die Liste:
[DEINE AUFGABEN]
```

Der Dreh: Die eine Sache zum Abgeben oder Streichen ist oft die wertvollste Zeile der Antwort.

**Eine freundliche Absage an einen Bewerber.** Jemand war sympathisch, passt aber nicht. Eine Absage, die nicht nach Textbaustein klingt.

```
Du bist eine erfahrene Personalerin im Mittelstand. Schreib eine Absage an eine
Bewerberin, die wir sympathisch fanden, aber nicht nehmen:
- wertschätzend, konkret, kein Floskel-Deutsch
- ohne falsche Hoffnung zu machen
- kurz
Hintergrund: [z.B. starke Bewerbung, aber eine andere passte fachlich besser].
```

Der Dreh: Ein konkreter Satz, warum es nicht gepasst hat, ist mehr wert als drei Zeilen Bedauern.

**Eine angespannte Mail entschärfen.** Wenn du am liebsten scharf zurückschießen würdest, es aber besser sein lässt.

```
Hier ist ein Entwurf, den ich gerade aus Frust geschrieben habe. Schreib ihn so um,
dass er höflich, aber bestimmt bleibt. Inhalt gleich, Schärfe raus.
Hier der Entwurf:
[ENTWURF EINFÜGEN]
```

Der Dreh: Erst rausschreiben, dann entschärfen lassen. Spart Nerven und einen Konflikt.

**Eine Anleitung, die ein Neuer versteht.** Das, was nur in deinem Kopf steht, soll jemand anderes machen können. Erst füttern, dann schreiben lassen.

*1 · Erst der KI deinen Ablauf erklären.*

```
Ich erkläre dir einen Ablauf bei uns, damit du ihn gleich sauber aufschreiben kannst.
Stell mir Rückfragen, wenn etwas unklar ist. Hier der Ablauf in Stichpunkten:
[DEINE STICHPUNKTE]
```

*2 · Dann die Anleitung schreiben lassen.*

```
Mach daraus eine Schritt-für-Schritt-Anleitung für jemanden, der das zum ersten Mal macht:
- nummerierte Schritte, je einer pro Zeile
- pro Schritt, worauf man achten muss
- am Ende: was schiefgehen kann und was dann zu tun ist.
```

Der Dreh: Ohne Schritt 1 erfindet die KI einen Ablauf, der zu keiner Firma passt. Das Füttern macht den Unterschied.

**Die KI als Sparringspartner für eine Entscheidung.** Eine Entscheidung, bei der du dich im Kreis drehst. Drei Schritte: ausbreiten, widersprechen, entscheiden.

*1 · Erst sauber ausbreiten.*

```
Ich stehe vor einer Entscheidung: [ENTSCHEIDUNG].
Leg mir Vor- und Nachteile auf den Tisch, dazu die Risiken, die ich vielleicht
übersehe. Noch keine Empfehlung.
```

*2 · Dann den Gegenwind holen.*

```
Jetzt argumentier überzeugend für die Option, zu der ich gerade NICHT neige.
Was spricht dafür, das ich zu schnell weggewischt habe?
```

*3 · Erst dann die Empfehlung.*

```
Jetzt deine Einschätzung: was würdest du tun und warum? Und nenn die eine Sache,
die deine Empfehlung kippen würde.
```

Der Dreh: Der Gegenwind in Schritt 2 ist der ganze Wert. Eine KI, die dir nur recht gibt, hilft dir nicht.

## Bevor du abschickst

- Rolle und Zielgruppe genannt?
- Genug Kontext mitgegeben, den nur du im Kopf hast?
- Form, Länge und Ton vorgegeben?
- Ein Beispiel mitgegeben, wenn es auf den Stil ankommt?
- Bei größeren Aufgaben: in zwei, drei Prompts zerlegt statt alles in einen?
- Gesagt, was es NICHT sein soll?
