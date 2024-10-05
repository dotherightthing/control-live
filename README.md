# control-live

Utilities to control Ableton Live

## Stream Deck XL (macOS)

### Set up Virtual MIDI ports

1. Open Audio MIDI Setup
2. Double-click IAC Driver (in red)
3. Click `+` to add a Bus
4. Double-click the bus name and rename to `StreamDeck2Daw`
5. Click `+` to add a second Bus
6. Double-click the second bus name and rename to `Daw2StreamDeck`
7. Ensure that *Device is online* is checked
8. Click *Apply*

### Enable Virtual MIDI ports

1. Open Ableton Live
2. Open *Settings* > *Link, Tempo & MIDI*
3. Under *Input Ports*, locate *IAC Driver (StreamDeck2Daw)* and select the *Track* and *Remote* checkboxes
4. Under *Input Ports*, locate *IAC Driver (Daw2StreamDeck)* and select the *Track* and *Remote* checkboxes

### Send MIDI from Stream Deck to Live

1. *Configure Stream Deck* > *Midi* ([Stream Deck Midi plugin](https://trevligaspel.se/streamdeck/midi/index.php))
2. Drag desired action to a slot, e.g. *Note On/Off* and configure as usual
3. Set *Midi Out port* to *IAC Driver StreamDeck2Daw*
4. Set *Midi In port* to *IAC Driver Daw2StreamDeck*
