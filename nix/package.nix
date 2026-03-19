{ inputs, ... }:
{
  perSystem =
    { self', pkgs, ... }:
    {

      packages =
        let
          project = inputs.pyproject-nix.lib.project.loadPyproject {
            projectRoot = ../.;
          };
          buildAttr = project.renderers.buildPythonPackage { python = pkgs.python3; };
        in
        {
          default = self'.packages.otterwiki;
          otterwiki = pkgs.python313.pkgs.buildPythonApplication (
            buildAttr
            // {
              version = "2.18.1";
              # dont run tests, we belive in code
              env.dontCheckRuntimeDeps = "true";
            }
          );
        };

    };

}
