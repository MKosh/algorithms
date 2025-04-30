const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

pub fn Queue(comptime T: type) type {
    return struct {
        length: usize,
        first: ?*Node,
        last: ?*Node,
        allocator: Allocator,
        const Self = @This();

        const Node = struct {
            item: T,
            next: ?*Node,
        };

        pub fn init(allocator: Allocator) !Queue(T) {
            return .{.length = 0, .first = null, .last = null, .allocator = allocator};
        }

        pub fn isEmpty(self: Self) bool {
            if (self.length == 0) {
                return true;
            } else {
                return false;
            }
        }

        pub fn enqueue(self: *Self, item: T) !void {
            var old_last = self.last;
            self.last = try self.allocator.create(Node);
            self.last.?.item = item;
            self.last.?.next = null;
            if (self.isEmpty()) {
                self.first = self.last;
            } else {
                old_last.?.next = self.last;
            }
            self.length += 1;
        }

        pub fn dequeue(self: *Self) !?T {
            const item = self.first.?.item;
            self.first = self.first.?.next;
            self.length -= 1;
            if (self.isEmpty()) self.last = null;
            return item;
        }
    };
}

test "Queue" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var queue = try Queue(i32).init(allocator);
    try expect(queue.isEmpty());
    try queue.enqueue(1);
    try queue.enqueue(10);
    try expect(queue.length == 2);
    try expect(try queue.dequeue() == 1);
    try expect(try queue.dequeue() == 10);
    try expect(queue.isEmpty());
}

