const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

pub fn Deque(comptime T: type) type {
    return struct {
        const Self = @This();
        const Node = struct {
            item: T,
            next: ?*Node,
        };
        length: usize,
        first: ?*Node = null,
        last: ?*Node = null,

        pub fn isEmpty(self: Self) bool {
            return self.length == 0;
        }
        
        pub fn size(self: Self) usize {
            return self.length;
        }

        pub fn pushLeft(self: *Self, new_node: *Node) void {
            
        }

    };
}

pub fn main() void {
}
