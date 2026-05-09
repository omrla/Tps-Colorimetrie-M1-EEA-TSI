clear all; close all; clc;
m = [0.488718 0.176204 0;0.310680 0.812985 0.0102048;0.200602 0.0108109 0.989795];
n = inv(m);
X = input('Donner la valeur de X : ');
Y = input('Donner la valeur de Y : ');
Z = input('Donner la valeur de Z : ');
XYZ = [X Y Z];
gamma = 2.2;
rgb = XYZ*n;
R = rgb(1)^(1/2.2)
G = rgb(2)^(1/2.2)
B = rgb(3)^(1/2.2)