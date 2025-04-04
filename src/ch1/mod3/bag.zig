const std = @import("std");
const print = std.debug.print;

pub fn Bag(comptime T: type) type {
    return struct {
        const Self = @This();
        data: []T,
        size: i32,
    };
}

pub fn main() !void {
    var buffer = [_]i32{ 1, 2, 3, 4, 5 };
    const bag = Bag(i32){ .data = &buffer, .size = buffer.len };

    for (bag.data) |value| {
        print("{d}\n", .{value});
    }
}
