# Control Live

## System requirements

* macOS (tested on *Sonoma 14.7.1*)
* Ableton Live (tested on *Live 12*)
* Push 2
* ClyphX Pro (for *Live 12*)
* Terminal (to run installation script)

### For Stream Deck controls

* Elgato Stream Deck XL

---

## Ableton Live

### Set up Virtual MIDI ports

These allow the Stream Deck XL and Ableton Live to communicate.

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