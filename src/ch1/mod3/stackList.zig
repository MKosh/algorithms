const std = @import("std");
const print = std.debug.print;
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

        pub fn deinit(self: *Self) void {
            var iter = self.first;
            while (iter) |current| {
                iter = current.next;
                self.allocator.destroy(current);
            }
            print("Stack deinitialized!\n", .{});
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
            const first = self.first orelse return null;
            const item = first.data;
            self.first = first.next;
            self.allocator.destroy(first);
            self.length -= 1;
            return item;
        }

        pub fn delete(self: *Self, k: usize) void {
            var iter = self.first orelse return;
            if (k == 0) {
                self.first = iter.next;
                self.allocator.destroy(iter);
                self.length -= 1;
                return;
            }

            for (0..k - 1) |_| {
                if (iter.next) |next| {
                    iter = next;
                }
            }

            if (iter.next) |kth_node| {
                iter.next = kth_node.next;
                self.allocator.destroy(kth_node);
            }
            self.length -= 1;
        }

        pub fn find(self: Self, key: T) bool {
            var iter = self.first orelse return false;
            if (iter.data == key) return true;
            while(iter.next) |next| : (iter = next){
                if (next.data == key) return true;
            }
            return false;
        }

        pub fn removeAfter(self: *Self, node: *Node) void {
            const temp = node.next orelse return;
            if (node.next.?.next) |next| {
                node.next = next;
            }
            self.allocator.destroy(temp);
            self.length -= 1;
        }

        pub fn insertAfter(self: *Self, node: *Node, key: T) void {
            const new = self.allocator.create(Node) catch unreachable;
            new.data = key;
            new.next = node.next;
            node.next = new;
            self.length += 1;
        }

        pub fn get(self: Self, key: T) ?*Node {
            var iter = self.first orelse return null;
            if (iter.data == key) return iter;
            while (iter.next) |next| : (iter = next) {
                if (next.data == key) return next;
            }
            return null;
        }

    };
}

test "Linked list stack" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var stack = try Stack(i32).init(allocator);
    defer stack.deinit();

    try stack.push(1);
    try stack.push(3);

    try expect(stack.first.?.data == 3);
    try expect(stack.pop() == 3);
    try expect(stack.pop() == 1);
    try expect(stack.pop() == null);

    try expect(!stack.find(1));

    try stack.push(0);
    try stack.push(1);
    try stack.push(2);
    try stack.push(3);

    try expect(stack.length == 4);
    try expect(stack.find(3));
    try expect(!stack.find(12));

    stack.delete(0);
    try expect(stack.length == 3);

    stack.delete(1);
    try expect(stack.length == 2);
    stack.delete(0);
    stack.delete(0);

    try stack.push(0);
    try stack.push(1);
    try stack.push(2);
    try stack.push(3);

    var it = stack.first;
    const n = stack.get(1) orelse null;
    while (it) |iter| : (it = iter.next) {
        print("node: {d}\n", .{iter.data});
    }
    print("\n", .{});

    if (n) |node| {
        _ = stack.insertAfter(node, 12);
    }
    it = stack.first;
    while (it) |iter| : (it = iter.next) {
        print("node: {d}\n", .{iter.data});
    }
    print("\n", .{});

    try expect(stack.find(12));

    if (n) |node| {
        _ = stack.removeAfter(node);
    }
    it = stack.first;
    while (it) |iter| : (it = iter.next) {
        print("node: {d}\n", .{iter.data});
    }
    print("\n", .{});
}

pub fn main() void {
}
