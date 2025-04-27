const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

pub fn Stack(comptime T: type) type {
    return struct {
        length: usize,
        first: ?*Node,
        allocator: Allocator,
        const Self = @This();

        const Node = struct{
            data: T,
            next: ?*Node,
        };

        pub fn init(allocator: Allocator) !Stack(T) {
            return .{.length = 0, .first = null, .allocator = allocator};
        }

        pub fn isEmpty(self: Self) bool {
            if (self.length == 0) {
                return true;
            } else {
                return false;
            }
        }

        pub fn size(self: Self) usize {
            return self.length;
        }

        pub fn push(self: *Self, item: T) !void {
            const old_first = self.first;
            self.first = try self.allocator.create(Node);
            self.first.?.data = item;
            self.first.?.next = old_first;
            self.length += 1;
        }
        
        pub fn pop(self: *Self) ?T {
            if (self.length == 0) {
                return null;
            }
            const item = self.first.?.data;
            const temp = self.first.?.next;
            self.allocator.destroy(self.first.?);
            self.first = temp;
            self.length -= 1;
            return item;
        }

    };
}

test "Linked list stack" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var stack = try Stack(i32).init(allocator);
    try stack.push(1);
    try expect(stack.first.?.data == 1);
    try stack.push(3);
    try expect(stack.first.?.data == 3);
    try expect(stack.pop() == 3);
    try expect(stack.pop() == 1);
    try expect(stack.pop() == null);
}

pub fn main() void {}
