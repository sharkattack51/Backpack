# Backpack
Backpack is skeleton of the project of as3.

Can be used in both of the projects of the AIR / Flash, it will help the start of the project.
Key input, sound, and debugging, the manager class that manages the scene State has,
Simply by editing the State class you can start the project.

If you want to use the UI library can use the [Karabiner](https://github.com/sharkattack51/Karabiner).

## Require

- [Karabiner](https://github.com/sharkattack51/Karabiner)
- [SWFProfiler](http://lostinactionscript.com/2008/10/06/as3-swf-profiler/)

## Usage

`src/ApplicationMain.as` is the entry point of the AIR project,
`src/Main.as` is the entry point of the Flash project.

`src/Constant/SCENE_STATE.as` add the State class definition for the scene transition.
Add the **Constant** and **Class Definition**.

`src/State` add the State class.
Create a State class inherits `BackPack.Base.StateBase`.

State class has a View is MoviClip.
When a scene transition, when the State is changed by `SceneStateManager.ChangeState()` Switch the View.

---

##### src/ApplicationMain.as

Entry point of the AIR project. AIR project at the time is specified in the Document Class.
And the application startup argument, you can set the external application to simultaneous start.

##### src/Main.as

Entry point of the Flash project. Flash project at the time is specified in the Document Class.
During initialization reads the configuration file, you can use the value in the subsequent timing.
It also provides a means for accessing each manager class.
It has one of the View Container, all of the View element will be added here.
Others, input mode setting, mouse pointer setting, debug setting, window setting, JS callback set, and logger setting.

##### src/DebugManager.as

It provides the functionality for debugging.
Console layer of run-time Trace for confirmation will be set.

##### src/KeyInputManager.as

Will receive a key input events to the Stage.
It can use to add One the required key events.

##### src/SoundManager.as

It provides a sound playback function of the SE and BGM.
Add a Sound object class to be generated and used.

##### src/SceneStateManager.as

To manage the scene State, it makes the transition process.
Define the State class in `src/Constant/SCENE_STATE.as`,
In `src/State` use by adding the State class.

##### lib/Backpack/Base/StateBase.as

This is the base class for the State class. It has a View is a MovieClip,
has been defined in the `lib/Backpack/Interface/IState.as` by `StateStart()`, to add the View to the Stage.
Remove the View from the Stage Similarly, in `StateExit()`.
By `SceneStateManager` of `ChangeState()`, after the current State `StateExit()`is called of the transition destination State `StateStart()` it will be called.
Then, by EnterFrame Event `StateUpdate()` it will be called.

##### lib/Backpack/Util/ApplicationSetting.as

It reads the `bin/ApplicationSetting.xml` of external configuration files, to hold the value.
Each set value can be retrieved by performing a type check by `ApplicationSetting.Instance.GetXXXX()`.
Refer to the `bin/ApplicationSetting.xml` XML format.

##### lib/Backpack/Util/Logger.as

`Logger.Log()` by do the log output.
Will be output to the `bin/log`.
