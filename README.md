# control-live

Utilities to control Ableton Live

## Mackie MCU Pro

The *FUNCTION SELECT* and *GLOBAL VIEW* buttons send MIDI and can be mapped.

ClyphX expects note numbers. These require a [conversion between note and number](https://computermusicresource.com/midikeys.html).

Note: *Bome Incoming* is configured to *Middle C is: C3*.

Some functions are shared with the Stream Deck while I work out the best workflow.

| Position | MCU Pro Button   | MCU Pro MIDI Note | MIDI Number | Handler                  | Function               |
|----------|------------------|-------------------|-------------|--------------------------|------------------------|
| Top 1    | F1               | F#2               | 54          | Clyphx - X-Control       | AUTOMATION_ARM         |
| Top 2    | F2               | G2                | 55          | Clyphx - X-Control       | AUTOMATION_REENABLE    |
| Top 3    | F3               | G#2               | 56          | Clyphx - X-Control       | SESSION_REC            |
| Top 4    | F4               | A2                | 57          |                          |                        |
| Top 5    | F5               | A#2               | 58          |                          |                        |
| Top 6    | F6               | B2                | 59          |                          |                        |
| Top 7    | F7               | C3                | 60          |                          |                        |
| Top 8    | F8               | C#3               | 61          |                          |                        |
| Btm 1    | MIDI TRACKS      | D3                | 62          | Bome - MCU + Stream Deck | Expand/Collapse Groups |
| Btm 2    | INPUTS           | D#3               | 63          |                          |                        |
| Btm 3    | AUDIO TRACKS     | E3                | 64          | Bome - MCU + Stream Deck | Split                  |
| Btm 4    | AUDIO INSTRUMENT | F3                | 65          | Bome - MCU + Stream Deck | Save As                |
| Btm 5    | AUX              | F#3               | 66          | Bome - MCU + Stream Deck | Save                   |
| Btm 6    | BUSSES           | G3                | 67          | Bome - MCU + Stream Deck | EXT                    |
| Btm 7    | OUTPUTS          | G#3               | 68          |                          |                        |
| Btm 8    | USER             | A3                | 69          |                          |                        |

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

---

## Presample Selected Track

### Files

* `src/live/Audio Effects/Max Audio Effect/cl-presample-selected-track.js`
* `src/live/Audio Effects/Max Audio Effect/Presample Selected Track.amxd`

### Description

When jamming with soft synths or hardware synths, MIDI notes are driving that synth. Recording into the instrument channel would therefore record the MIDI input rather than the audio output. When recorded MIDI is played back at a later date, the sound is often different to what was originally played, due to some combination of synth settings not being saved with the MIDI input (this is especially the case with hardware synths). In this instance it's better to capture the audio output rather than the MIDI input. For synths that don't have MIDI input, audio capture is the only option.

On the Push2, creation of a track-based audio (or MIDI) resampling track necessitates multiple button presses and two hands. This interrupts the creative flow as it requires extensive hand-eye coordination:

1. Press 'Mix'
2. Press 'Mix'
3. Press to select 'Input & Output'
4. Scroll to select 'Input Type'
5. Press Record + Track Select
6. Rename new track in software
7. Recolour new track

Key/MIDI mapping the `Insert before` and `Insert after` buttons automates this process, by:

1. inserting a new track BEFORE (to the left of) or AFTER (to the right of) the selected track
2. matching the type of the new track to the type of the selected track (Audio or MIDI)
3. setting the input of the new track to the name of the selected track
4. arming the new track
5. naming the new track to indicate the source name and the time of creation
6. recolouring the new track to match the selected track's colour
7. returning the focus to the selected track

Recording can now be started via a single button press on the desired clip slot.

Note: This patch is functionally similar to ClyphX Pro's `INSAUDIO`/`INSMIDI`.

### Usage

1. add *Presample Selected Track.amxd* to the Master **Audio** track in Ableton Live
   * map button on Push2 or other controller to `Insert before` and/or `Insert after` button
2. select an Audio, MIDI, or Instrument track
   * push mapped button from (2) to insert a resampling track
   * alternatively use [Mira](https://cycling74.com/products/mira/) to view the Mira frame on an iPad, then tap one of the *(Mira)* buttons to insert a resampling track

---

## Rename Selected Track

### Files

* `src/live/Audio Effects/Max Audio Effect/cl-rename-selected-track.js`
* `src/live/Audio Effects/Max Audio Effect/Rename Selected Track.amxd`

### Description

When jamming it's easy to lose track of what each track represents. This function provides a quick way to name the track from a list of common options.

### Usage

1. add *Rename Selected Track.amxd* to the Master **Audio** track in Ableton Live
   * map tabs object to encoder on non-Push controller
2. select an Audio, MIDI, or Instrument track
   * turn mapped encoder from (2) to change the track name and see it update instantly
   * alternatively use [Mira](https://cycling74.com/products/mira/) to view the Mira frame on an iPad, then tap a tab (option) on Mira to change the selected track name
   * alternatively lock Push to the device on the Master track, and turn the `TRACKNAME` encoder

---

## Insights

### Passing variables to the JavaScript file

#### Technique A: Arguments

Patcher:

```txt
[live.tab] # UI object sending input to script
  | | |
    |
  [js script-name.js] # js object containing script (see list of tested variations below)
```

JS:

```js
function bang()
  if (jsarguments.length > 1) {
    post(jsarguments[0]); // script name
    post(jsarguments[1]); // first argument
  }
}
```

I couldn't figure out how to use a dynamic value with this approach, as when a value is sent into the `js` object's inlet,
it is treated as a function name rather than a string argument. That generates an error as there is no matching function.

> js: no function argName [script-name.js]

This error can be mitigated by adding an `anything()` function:

```js
function anything() {
  console.log(jsarguments.length);
  console.log(jsarguments[0], jsarguments[1]);
}
```

However I still couldn't figure out how to pass in a reference to the Symbol value generated by the middle outlet of `live.tab`:

```txt
js script-name.js              => anything() => script-name.js, <undefined>
sprintf js script-name.js %s   => anything() => no output
prepend js script-name.js      => anything() => no output
js rename-selected-track.js $1 => anything() => script-name.js, $1
js rename-selected-track.js $s => anything() => script-name.js, $s
```

Links:

* <https://docs.cycling74.com/max8/refpages/js#jsarguments>
* <https://docs.cycling74.com/max8/vignettes/jsbasic#How_Input_to_the_js_Object_is_Handled>

#### Technique B: Listeners

Patcher:

```txt
[live.tab] # UI object to listen to in script + named  (via the Scripting Name field?)

[live.button] # live.button object to send bang
  |
[js script-name.js] # js object containing script
```

JS:

```js
function bang() {
  // Run garbage collection
  gc();

  // Target object from patcher
  const obj = this.patcher.getnamed('namedObject');

  // Assign listener
  const ml = new MaxobjListener(obj, objCallback);

  // Get the current value
  post(ml.getvalue());
}

// When the listener detects a change, fire a callback
function objCallback(data) {
  // Get the latest value
  post(data.value);
}
```

Issues:

When the object has multiple outlets, you can't choose the one with the data type you want.
For the `live.tab` object, I wanted the middle outlet (string `Symbol`) not the left outlet (`Item Index`).
The latter would have only been useful if had access to the object's `enum` so I could get the string that the index referred to.

Links:

* <https://docs.cycling74.com/max8/vignettes/scripting_topic> - `maxobjlistener-example.maxpat`
* <https://docs.cycling74.com/max8/vignettes/jsmaxobjlistener>

#### Technique C: Global functions

As the above two techniques didn't work for me, I settled on using global functions.
This encouraged me to merge several separate scripts into one, and then to hide helper functions using `privateFunctionName.local = 1`.

Patcher:

```txt
[live.tab] # UI object sending input to script
  | | |
    |
[functionName $1] # message object containing function to call + variable argument
    |
  [js script-name.js] # js object containing script containing function
```

JS:

```js
function functionName(arg) {
  post(arg);
}
```

Links:

* <https://docs.cycling74.com/max8/vignettes/jsbasic#Private_(Local)_Functions>

---

### Inspector: Bang when Transition from

For buttons (`live.text`) MIDI mappable controls should activate on mouse down AND mouse up, to prevent 2 clicks being required to repeat the action.

For buttons (`live.text`) Mira-only controls should only activate on transition from zero to one, otherwise every touch would trigger the action twice.

---

### Mira

#### Mira supports

* `live.dial` (with label)
* `live.grid`
* `live.meter`
* `live.number`
* `live.slider`
* `live.tab`
* `live.text` (with label - button/toggle, also see prototypes)
* `live.toggle`

#### Mira does not support

* `live.adsrui`
* `live.arrows`
* `live.comment`
* `live.gain`
* `live.line`
* `live.menu`
* `live.scope`
* `live.step`

#### Links

* [Mira iPad app (Cycling 74)](https://cycling74.com/products/mira/)
