# This file has been generated by node2nix 1.11.1. Do not edit!

{nodeEnv, fetchurl, fetchgit, nix-gitignore, stdenv, lib, globalBuildInputs ? []}:

let
  sources = {
    "zenn-cli-0.1.158" = {
      name = "zenn-cli";
      packageName = "zenn-cli";
      version = "0.1.158";
      src = fetchurl {
        url = "https://registry.npmjs.org/zenn-cli/-/zenn-cli-0.1.158.tgz";
        sha512 = "bvQ96fK+9qw+SKxEmncg/rYU+1u0V6Bh+HuV8By+u4L+VZt/jn9hFyL+KWj/2ncSBDtcEBo6XLsCdNLxlUo+RA==";
      };
    };
  };
  args = {
    name = "zenn";
    packageName = "zenn";
    version = "1.0.0";
    src = ./.;
    dependencies = [
      sources."zenn-cli-0.1.158"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
in
{
  args = args;
  sources = sources;
  tarball = nodeEnv.buildNodeSourceDist args;
  package = nodeEnv.buildNodePackage args;
  shell = nodeEnv.buildNodeShell args;
  nodeDependencies = nodeEnv.buildNodeDependencies (lib.overrideExisting args {
    src = stdenv.mkDerivation {
      name = args.name + "-package-json";
      src = nix-gitignore.gitignoreSourcePure [
        "*"
        "!package.json"
        "!package-lock.json"
      ] args.src;
      dontBuild = true;
      installPhase = "mkdir -p $out; cp -r ./* $out;";
    };
  });
}
