{ userSettings, ... }:

{
  environment.variables = {
    EDITOR = userSettings.editor;
  };
}
