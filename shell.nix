{ 
	pkgs ? import <nixpkgs> {
		inherit system;
	}, system ? builtins.currentSystem}:
let
	nodeDependencies = (pkgs.callPackage ./default.nix {}).nodeDependencies;
in
pkgs.mkShell {
	pure = true;
	buildInputs = with pkgs; [
		git
		nodejs_22
		nodePackages.pnpm
	];
	shellHook = ''
		ln -s ${nodeDependencies}/lib/node_modules ./node_modules
		export PATH="${nodeDependencies}/bin:$PATH"
		echo "Node.js Develop Environment is Activated"
	'';
}
