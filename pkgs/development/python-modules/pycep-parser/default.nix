{ lib
, assertpy
, buildPythonPackage
, fetchFromGitHub
, lark
, poetry-core
, pytestCheckHook
, pythonOlder
, regex
, typing-extensions
}:

buildPythonPackage rec {
  pname = "pycep-parser";
  version = "0.3.5";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "gruebel";
    repo = "pycep";
    rev = "refs/tags/${version}";
    hash = "sha256-Nj/drNRSIBh8DaE+vzQRijQg8NVUK5qBClwU3aWiA48=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    lark
    regex
    typing-extensions
  ];

  checkInputs = [
    assertpy
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace 'regex = "^2022.3.15"' 'regex = "*"'
  '';

  pythonImportsCheck = [
    "pycep"
  ];

  meta = with lib; {
    description = "Python based Bicep parser";
    homepage = "https://github.com/gruebel/pycep";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
