const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

pub fn fixedStack(comptime T: type, capacity: i32) type {
    return struct {
        const Self = @This();
        data: [capacity]T,
        size: u32,

        pub fn init() Self {
            return Self{ .data = std.mem.zeroes([capacity]T), .size = 0 };
        }
        pub fn isEmpty(self: Self) bool {
            return self.size == 0;
        }

        pub fn push(self: *Self, value: T) !void {
            if (self.size < capacity) {
                self.data[self.size] = value;
                self.size += 1;
                return;
            } else {
                return error.MyStackOverflow;
            }
        }
    };
}

pub fn ResizingArrayStack(comptime T: type) type {
    return struct {
        const Self = @This();
        data: [1]T,
        size: u32,

        pub fn init() Self {
            return Self{ .data = [1]T{0}, .size = 0 };
        }

        pub fn isEmpty(self: Self) bool {
            return self.size == 0;
        }

        pub fn getSize(self: Self) u32 {
            return self.size;
        }

        pub fn push(self: *Self, value: T) void {
            if (self.size == self.data.len) {
                self.resize(2 * self.data.len);
            }
            self.data[self.size] = value;
            self.size += 1;
        }

        fn resize(self: *Self, max: u32) void {
            // var temp = [_]T{0} ** max;
            // var temp = std.mem.zeroes([max]T);
            var temp = [1]T{0} ** max;

            for (self.data, 0..) |elem, i| {
                temp[i] = elem;
            }
            self.data = temp;
        }
    };
}

pub fn main() !void {}

test "Resizing stack" {
    var stack = ResizingArrayStack(i32).init();
    stack.push(1);
    print("index: {d}, value: {d}\n", .{ 0, stack.data[0] });
    try expect(true);
}

test "fixed stack" {
    var stack = fixedStack(i32, 10).init();
    for (0..10) |i| {
        try stack.push(@intCast(i));
    }
    try expect(stack.data.len == 10);
    try expect(stack.size == 10);
    try expect(stack.data[3] == 3);
}
