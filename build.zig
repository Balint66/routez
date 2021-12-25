const std = @import("std");
const Builder = std.build.Builder;
const pkgs = @import("deps.zig").pkgs;
const exports = @import("deps.zig").exports;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const tests = b.addTest("test.zig");
    tests.setBuildMode(mode);
    pkgs.addAllTo(tests);
    //tests.addPackagePath("zuri", "zuri/src/zuri.zig");

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&tests.step);

    var basic = b.addExecutable("basic", "examples/basic.zig");
    basic.setBuildMode(mode);
    pkgs.addAllTo(basic);
    basic.addPackage(exports.routez);
    basic.setOutputDir("zig-cache");
    basic.install();
    const basic_step = b.step("basic", "Basic example");
    basic_step.dependOn(&basic.run().step);
}
