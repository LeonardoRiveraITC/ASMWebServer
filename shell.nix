{ system ? builtins.currentSystem, lib ? import <nixpkgs/lib>,... }:
let 
	pkgs = import <nixpkgs>{inherit system;};
	in
	pkgs.mkShell {
	    name="ASMDEVENV";
	    packages = [
		    #pkgs.su
		    #pkgs.slirp4netns
		    pkgs.gcc
		    pkgs.gdb
		    pkgs.strace
		    pkgs.valgrind
		    pkgs.killall
	    ];
}
