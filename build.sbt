// See README.md for license details.

ThisBuild / scalaVersion     := "2.13.14"
ThisBuild / version          := "1.0.0"
ThisBuild / organization     := "Mark van Damme"

val chiselVersion = "3.6.1"

lazy val root = (project in file("."))
  .settings(
    name := "TinyPong",
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % chiselVersion,
      "edu.berkeley.cs" %% "chiseltest" % "0.6.2"
    ),
    scalacOptions ++= Seq(
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit",
      "-Ymacro-annotations",
    ),
    addCompilerPlugin("edu.berkeley.cs" %% "chisel3-plugin" % chiselVersion cross CrossVersion.full),
  )
