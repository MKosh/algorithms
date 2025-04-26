const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

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

// Based on the stack implementation from the zig book
pub fn Stack(comptime T: type) type {
    return struct {
        items: []T,
        capacity: usize,
        length: usize,
        allocator: Allocator,
        const Self = @This();

        pub fn init(allocator: Allocator, capacity: usize) !Stack(T) {
            var buffer = try allocator.alloc(T, capacity);
            return .{ .items = buffer[0..], .capacity = capacity, .length = 0, .allocator = allocator };
        }

        pub fn push(self: *Self, value: T) !void {
            if (self.length + 1 > self.capacity) {
                var temp = try self.allocator.alloc(T, self.capacity * 2);
                @memcpy(temp[0..self.capacity], self.items);
                self.allocator.free(self.items);
                self.items = temp;
                self.capacity = self.capacity * 2;
            }

            self.items[self.length] = value;
            self.length += 1;
        }

        pub fn pop(self: *Self) ?u32 {
            if (self.length == 0) {
                return null;
            }
            const temp = self.items[self.length - 1];
            self.items[self.length - 1] = undefined;
            self.length -= 1;
            return temp;
        }

        pub fn deinit(self: *Self) void {
            self.allocator.free(self.items);
        }
    };
}

pub fn main() !void {}

test "Stack" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var stack = try Stack(u32).init(allocator, 10);
    try stack.push(1);
    try stack.push(3);
    try expect(stack.capacity == 10);
    try expect(stack.items[0] == 1);
    try expect(stack.items[1] == 3);
    try expect(stack.pop() == 3);
    try expect(stack.pop() == 1);
    try expect(stack.pop() == null);
    try expect(stack.length == 0);
    stack.deinit();
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
