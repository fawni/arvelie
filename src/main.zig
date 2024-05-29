const std = @import("std");
const epoch = std.time.epoch;

const YEAR_ZERO = 2000;
const TIMEZONE_OFFSET = 3 * 60 * 60;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const timestamp = @as(u64, @intCast(std.time.timestamp())) + TIMEZONE_OFFSET;
    const epoch_seconds = epoch.EpochSeconds{ .secs = timestamp };
    const epoch_days = epoch_seconds.getEpochDay();

    const ynd = epoch_days.calculateYearDay();
    const year = ynd.year;
    const yearday = ynd.day;

    const month = @as(u8, @intCast(yearday / 14));
    const day = @as(u8, @intCast(yearday % 14));
    var month_char: u8 = 'A' + month;
    if (month_char == 'Z' + 1) {
        month_char = '+';
    }
    try stdout.print("{d:0>2}{c}{d:0>2}\n", .{ year - YEAR_ZERO, month_char, day });
}
