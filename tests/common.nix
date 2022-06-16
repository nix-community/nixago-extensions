/* Common test runner used across all tests
*/
{ pkgs, make, exts }:
{ name, input, expected }:
let
  # Call make
  result = make (exts.${name} input);

  # Compare the result from make with the expected result
  der = pkgs.runCommand "test.${name}"
    { }
    ''
      cmp "${expected}" "${result.configFile}"
      touch $out
    '';
in
der
