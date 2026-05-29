# Die Prompt-Techniken

*Die Handgriffe, auf die sich OpenAI, Anthropic und Google einig sind, alltagstauglich und zum Kombinieren.*

> **Kostenlos aus der Blaumilch-Werkstatt.** Die Ausgabe auf Substack: https://blaumilch.substack.com/p/prompt-techniken
>
> Teil der Reihe **Besser prompten**: [Sammlung](besser-prompten.md) · [Grundausstattung](prompt-grundausstattung.md) · [Frameworks](prompt-frameworks.md) · [Techniken](prompt-techniken.md)
>
> Mehr von den Blaumilch-Agenten: https://github.com/pageBodyDE/blaumilch-agenten · https://blaumilch.substack.com

---

## Einleitung

Drei Hefte, ein Thema. In der Grundausstattung kamen die fünf Griffe und fertige Vorlagen. In den Prompt-Frameworks die benannten Gerüste. Jetzt das Letzte, was fehlt: die Techniken. Die Handgriffe, mit denen du aus jedem Modell mehr rausholst.

Eine Technik ist kein Gerüst, das du ausfüllst. Es ist ein Kniff, den du in jeden Prompt einbauen kannst, egal welches Framework. Mal ein Beispiel mitgeben, mal das Modell erst denken lassen, mal die Aufgabe zerlegen.

Das Schöne: Die großen Lehrer, OpenAI, Anthropic, Google, sind sich überraschend einig. Aus ihren langen Anleitungen bleiben am Ende eine Handvoll Techniken, die im Alltag wirklich zählen. Die nehmen wir uns vor.

Wie immer geht's um die normalen Chat-Modelle. Die schweren Sachen für Agenten und Entwickler sind eine andere Welt, für einen anderen Tag.

## Das Fundament · Technik ist nicht Framework

**Ein Handgriff, kein Gerüst.** Kurz zur Erinnerung: ein *Framework* ist das Gerüst (Rolle, Kontext, Aufgabe, Form). Eine *Technik* ist ein einzelner Kniff, den du da reinlegst. Du kannst CO-STAR nehmen UND ein Beispiel mitgeben UND es Schritt für Schritt denken lassen. Frameworks und Techniken schließen sich nicht aus, sie greifen ineinander.

**Du brauchst nicht alle auf einmal.** Fang mit einer an. Die meisten Ergebnisse werden schon besser, wenn du nur ein, zwei Beispiele mitgibst. Der Rest kommt, wenn die Aufgabe schwerer wird. Der Dreh: Techniken sind Werkzeuge im Gürtel, keine Checkliste, die du jedes Mal abarbeitest.

## Die Grundtechniken

**Beispiele mitgeben.** Die stärkste Technik überhaupt. Statt zu beschreiben, was du willst, zeig es. Häng zwei, drei Beispiele an, wie Eingabe und gewünschtes Ergebnis aussehen. Drei bis fünf reichen meist.

```
Wandle Produktmerkmale in Kundennutzen. Beispiele:
Merkmal: Akku hält 18 Stunden → Nutzen: ein ganzer Arbeitstag ohne Steckdose.
Merkmal: Gehäuse aus Edelstahl → Nutzen: übersteht den rauen Werkstatt-Alltag.
Jetzt du:
Merkmal: [DEIN MERKMAL] →
```

Wofür: immer, wenn Stil, Format oder Tonfall sitzen müssen. Ein gutes Beispiel schlägt drei Absätze Erklärung.

**Gib ihm den Stoff.** Modelle raten gern, wenn sie etwas nicht wissen. Nimm ihnen das Raten weg: füg den Text, die Zahlen, die Fakten direkt mit ein und sag, es soll nur daraus antworten.

```
Beantworte die Frage NUR auf Basis des folgenden Textes. Wenn die Antwort
nicht drinsteht, sag das offen.
Text:
[VERTRAG / PROTOKOLL / DOKUMENT EINFÜGEN]
Frage: [DEINE FRAGE]
```

Wofür: Fragen zu Verträgen, Protokollen, Richtlinien. Dein bestes Mittel gegen erfundene Antworten.

**Trenn mit Markierungen.** Wenn Anweisung und Material durcheinandergehen, rät das Modell, was wozu gehört. Setz klare Grenzen: drei Anführungszeichen, Bindestriche oder einfache Markierungen wie `<text>` und `</text>`.

```
Fass den Text zwischen den Markierungen in drei Sätzen zusammen.
<text>
[HIER DER LANGE TEXT]
</text>
```

Wofür: lange Eingaben, mehrere Textstücke, alles wo Anweisung und Inhalt sonst verschwimmen.

**Gib das Format vor.** Sag nicht nur, was du willst, sondern wie es aussehen soll. Eine Tabelle, eine nummerierte Liste, drei Stichpunkte, eine feste Vorlage. Je klarer die Form, desto weniger musst du nachbessern.

```
Gib mir das Ergebnis als Tabelle mit drei Spalten:
Aufgabe | Wer | Bis wann
Keine Einleitung, keine Erklärung, nur die Tabelle.
```

Wofür: alles, was du weiterverarbeitest oder gleichförmig brauchst. Listen, Tabellen, Vorlagen.

## Die Denk-Techniken

**Lass es Schritt für Schritt denken.** Bei kniffligen Aufgaben macht das Modell weniger Fehler, wenn es erst laut denkt und dann antwortet. Ein Satz genügt: „Denk in Schritten, bevor du antwortest."

```
Eine Lieferung kostet 1.240 Euro netto, dazu 19 Prozent, abzüglich 3 Prozent Skonto.
Rechne in einzelnen Schritten, zeig den Rechenweg, und gib am Ende den Betrag.
```

Wofür: Rechnen, Logik, mehrstufige Schlüsse. Achtung: die neuen Denk-Modelle machen das schon von selbst, da kannst du dir den Satz sparen.

**Gib ihm Raum, bevor es urteilt.** Verwandt, aber breiter: lass das Modell die Aufgabe erst durcharbeiten, ehe es ein Urteil fällt. Gerade wenn es etwas prüfen oder bewerten soll, sonst schießt es aus der Hüfte.

```
Prüf diesen Entwurf auf Schwachstellen. Geh ihn erst Absatz für Absatz durch und
notier, was dir auffällt. Fass DANN dein Urteil zusammen.
Entwurf:
[TEXT]
```

Wofür: prüfen, bewerten, gegenlesen. Erst arbeiten lassen, dann das Fazit, nicht umgekehrt.

**Erst einen Schritt zurück.** Bei großen Fragen hilft ein Umweg: lass das Modell zuerst die allgemeine Frage klären, und erst dann deine konkrete. Das holt das richtige Hintergrundwissen nach vorne.

```
Bevor du meine Frage beantwortest: Was macht eine gute Stellenanzeige im Handwerk
generell aus? Liste die Prinzipien.
Danach: schreib auf dieser Basis die Anzeige für unseren Monteur-Job.
```

Wofür: Strategie, Konzepte, alles wo das Modell sonst zu schnell ins Detail springt.

**Mehrere Wege, dann die beste.** Für wichtige Fragen: lass dir nicht eine Antwort geben, sondern mehrere, unabhängig voneinander. Wo sie sich einig sind, ist die Antwort meist robust.

```
Beantworte die folgende Frage drei Mal, jedes Mal mit einem frischen Gedankengang.
Vergleich die drei Ergebnisse und sag mir, worauf sie sich einigen.
Frage: [DEINE FRAGE]
```

Wofür: Einschätzungen, knifflige Urteile, wo eine einzelne Antwort dir zu wackelig ist.

**Zerleg es in Schritte.** Die Technik für alles Größere, und du kennst sie schon aus der Grundausstattung. Statt alles in einen Mega-Prompt zu packen, baust du eine Kette: ein Schritt, sein Ergebnis füttert den nächsten.

*1 · Erst rausziehen.*

```
Lies das Protokoll und zieh nur die offenen Aufgaben raus, als Liste.
[PROTOKOLL EINFÜGEN]
```

*2 · Dann weiterverarbeiten.*

```
Nimm diese Liste und mach daraus eine Mail ans Team: wer macht was bis wann,
freundlicher Ton.
```

Wofür: lange Dokumente, mehrstufige Aufgaben, alles wo ein einzelner Prompt überfordert wäre. Jeder Schritt wird für sich besser.

## Techniken kombinieren

Im echten Einsatz nimmst du selten nur eine Technik. Du legst sie übereinander. Hier eine Kundenbeschwerde, beantwortet mit vier Techniken auf einmal: Rolle, Stoff, Schritt für Schritt, Format.

```
Du bist im Kundenservice und souverän. [Rolle]
Hier die Beschwerde und unsere Lieferdaten: [STOFF EINFÜGEN]
Geh erst durch, was schieflief, dann formulier die Antwort. [Schritt für Schritt]
Gib mir: erst drei Stichpunkte zur Lage, dann die fertige Mail. [Format]
```

Der Dreh: Jede Technik für sich hilft ein bisschen. Übereinandergelegt machen sie aus einer mittelmäßigen Antwort eine gute.

## Welche Technik, wofür?

- Stil oder Tonfall müssen sitzen? Beispiele mitgeben (Few-Shot).
- Frage zu einem langen Dokument? Gib ihm den Stoff, lass ihn nur daraus antworten.
- Rechnen, Logik, mehrstufige Schlüsse? Schritt für Schritt denken lassen.
- Wichtige Einschätzung, die wackelig wäre? Mehrere Wege, dann die beste.
- Große, konzeptionelle Frage? Erst einen Schritt zurück.
- Großes Vorhaben oder langes Dokument? In Schritte zerlegen.
- Gleichförmiges Ergebnis zum Weiterverarbeiten? Format vorgeben und mit Markierungen trennen.
- Eine Technik reicht oft. Erst eine, dann nachschärfen.
