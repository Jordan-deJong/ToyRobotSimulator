Toy Robot Simulator
===================

Toy Robot is a simulator of a toy robot that moves on a tabletop.

You can play the robot at:

## http://toy-robot-simulator.herokuapp.com/

Commands
========

## PLACE X,Y,FACING

Put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST. If the robot is already placed, issuing another valid PLACE command will place the robot in the newly specified location.

## MOVE

Moves the toy robot one unit forward in the direction it is currently facing.

## LEFT

Rotates the robot 90 degrees to the left (i.e. counter-clockwise) without changing the position of the robot.

## RIGHT

Rotates the robot 90 degrees to the right (i.e. clockwise) without changing the position of the robot.

## REPORT

Announces the X,Y and F of the robot.

Installation
============

## PLATFORM

The below setup is for OS X Yosemite.

## RUBY ON RAILS

Ensure you have [Git](http://git-scm.com/downloads) and [Ruby 2.1.4](http://www.ruby-lang.org/en/downloads/) installed.  Then in a terminal execute:

    git clone git@github.com:Jordan-deJong/ToyRobotSimulator.git
    cd ToyRobotSimulator
    gem install bundler
    bundle install

## Run

In a terminal execute:

    rails s/server

Then go to http://localhost:3000/ in your web browser.
