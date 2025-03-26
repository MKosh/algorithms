const std = @import("std");
const print = std.debug.print;

const Counter = struct {
    name: []const u8,
    count: i32,

    pub fn init(name: []const u8) Counter {
        return Counter{ .name = name, .count = 0 };
    }

    pub fn increment(self: *Counter) void {
        self.count += 1;
    }

    pub fn tally(self: Counter) i32 {
        return self.count;
    }
};

pub fn main() !void {
    var heads = Counter.init("heads");
    var tails = Counter.init("tails");
    // const prnd = std.crypto.random;
    // const rand = prnd.float(32);
    // const now = try std.time.Instant.now();
    // var prng = std.Random.DefaultPrng.init(std.time.Instant.since(now, std.time.Instant.now()));
    var prng = std.Random.DefaultPrng.init(@intCast(std.time.timestamp()));
    const rand = prng.random();

    for (0..200) |_| {
        if (rand.float(f32) < 0.5) {
            // if (prnd.float(f32) <= 0.5) {
            heads.increment();
        } else {
            tails.increment();
        }
    }

    print("Heads: {d} | Tails {d}\n", .{ heads.tally(), tails.tally() });
}
