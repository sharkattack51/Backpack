# Backpack
Backpack is skeleton of the project of as3.

`Backpack` は as3 プロジェクトのスケルトンです。
AIR/Flash の両方のプロジェクトで使用でき、プロジェクトのスタートを助けます。
キー入力、サウンド、デバッグと、シーン State を管理するマネージャークラスを持ち、
State クラスを編集することで簡単にプロジェクトを開始することができます。

## Require

- [Karabiner](https://github.com/sharkattack51/Karabiner)
- [SWFProfiler](http://lostinactionscript.com/2008/10/06/as3-swf-profiler/)

## Usage

`src/ApplicationMain.as` は AIR プロジェクトのエントリーポイント、
`src/Main.as` は Flash プロジェクトのエントリーポイントです。

`src/Constant/SCENE_STATE.as` にはシーン遷移の為の State クラス定義を追加します。
**定数** と **クラス定義** を追加してください。

`src/State` には State クラスを追加します。
`BackPack.Base.StateBase` を継承して State クラスを作成してください。

State クラスは MoviClip である　View を持ちます。
シーン遷移時、`SceneStateManager.ChangeState()` によって State が変更されると View を切り替えます。

---

##### src/ApplicationMain.as

AIR プロジェクトのエントリーポイントです。 AIR プロジェクト時はドキュメントクラスに指定します。
アプリケーション起動時引数と、同時起動する外部アプリケーションを設定することが出来ます。

##### src/Main.as

Flash プロジェクトのエントリーポイントです。 Flash プロジェクト時はドキュメントクラスに指定します。
初期化時に設定ファイルを読み込み、以降のタイミングで値を利用することが出来ます。
また、各マネージャークラスにアクセスするための手段も提供します。
1つの View コンテナを持ち、全ての View 要素はここに追加されます。
その他、入力モード設定や、マウスポインタの表示設定や、デバッグ設定、ウィンドウ設定、JSコールバック設定、ロガー設定を行います。

##### src/DebugManager.as

デバッグ用の機能を提供します。
実行時 Trace 確認用のコンソールレイヤーが設定されます。

##### src/KeyInputManager.as

Stage へのキー入力イベントを受け取ります。
必要なキーイベントをつ追加して使用します。

##### src/SoundManager.as

SE、BGMのサウンド再生機能を提供します。
生成するSoundオブジェクトクラスを追加して使用します。

##### src/SceneStateManager.as

シーン State を管理し、遷移処理を行います。
`src/Constant/SCENE_STATE.as` に State クラスを定義し、
`src/State` に State クラスを追加して使用します。

##### lib/Backpack/Base/StateBase.as

State クラスの基底クラスです。MovieClip である View を持ち、`lib/Backpack/Interface/IState.as` に定義された
`StateStart()` により、Stage に View を追加します。
同様に `StateExit()` で Stage から View を取り除きます。
`SceneStateManager` の `ChangeState()` により、現在の State の `StateExit()` が呼ばれた後に
遷移先 State の `StateStart()` が呼ばれます。
その後、 EnterFrame イベントにより `StateUpdate()` が呼ばれます。

##### lib/Backpack/Util/ApplicationSetting.as

外部設定ファイルの `bin/ApplicationSetting.xml` を読み込んで、値を保持します。
各設定値は `ApplicationSetting.Instance.GetXXXX()` により型チェックを行って取得可能です。
XMLのフォーマットは `bin/ApplicationSetting.xml` を参照してください。

##### lib/Backpack/Util/Logger.as

`Logger.Log()` によりログ出力を行います。
`bin/log` に出力されます。