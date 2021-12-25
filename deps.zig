const std = @import("std");
pub const pkgs = struct {
    pub const zuri = std.build.Pkg{
        .name = "zuri",
        .path = .{ .path = ".gyro/zuri-Balint66-bd5749f7ea055a20051f66b848bef3437a2bbad1/pkg/src/zuri.zig" },
    };

    pub fn addAllTo(artifact: *std.build.LibExeObjStep) void {
        @setEvalBranchQuota(1_000_000);
        inline for (std.meta.declarations(pkgs)) |decl| {
            if (decl.is_pub and decl.data == .Var) {
                artifact.addPackage(@field(pkgs, decl.name));
            }
        }
    }
};

pub const exports = struct {
    pub const routez = std.build.Pkg{
        .name = "routez",
        .path = .{ .path = "src/routez.zig" },
        .dependencies = &.{
            pkgs.zuri,
        },
    };
};
pub const base_dirs = struct {
    pub const zuri = ".gyro/zuri-Balint66-bd5749f7ea055a20051f66b848bef3437a2bbad1/pkg";
};
