const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;
const eql = std.mem.eql;
const allocator = std.heap.page_allocator;

test "init array" {
    // Массивы имеют фиксированный размер,
    // их длина (количество элементов) известна во время компиляции.
    // Длина является составляющей частью типа, то есть
    // массив из 4-х знаковых целых ([4]i32) и
    // массив из 5-ти знаковых целых ([5]i32) - это разные типы.

    // Пример обычного массива
    // const message = [5]u8{ 'h', 'e', 'l', 'l', 'o' }; // явное указание длины
    const message = [_]u8{ 'h', 'e', 'l', 'l', 'o' }; // компилятор сам выведет длину
    
    // для каста массива к слайсу используется оператор &
    try expect(eql(u8, &message, "hello"));
    try expect(message.len == 5);
    try expect(@TypeOf(message) == [5]u8);
}

test "init slice" {
    // Срез — это просто указатель + длина
    // Он не управляет памятью, а только ссылается на уже существующие данные
    // Длина среза известная только в рантайме
    const stack_arr = [5]u8{ 1, 2, 3, 4, 5 }; // Массив на стеке
    var end: u32 = 3;
    end += 1;
    const stack_slice = stack_arr[1..end];
    try expect(@TypeOf(stack_arr) == [5]u8);
    try expect(@TypeOf(stack_slice) == []const u8);

    //
    const heap_slice = try allocator.alloc(u8, 100); // срез в куче
    defer allocator.free(heap_slice);
    try expect(@TypeOf(heap_slice) == []u8);
}

test "change array, slice" {
    // Нельзя изменять константный массив
    // также нельзя изменять слайс, если он
    // ссылается на константный массив
    // error: cannot assign to constant
    // const arr = [_]u8{ 1, 2, 3, 4, 5 };
    // arr[1] = 2;

    var arr = [_]u8{ 1, 2, 3, 4, 5 };
    arr[1] = 2; // можно
    try expect(arr[1] == 2);

    const heap_slice = try allocator.alloc(u8, 100); // срез в куче
    defer allocator.free(heap_slice);
    heap_slice[2] = 2; // можно
    try expect(heap_slice[2] == 2);

    // Тут вы справедливо возразите - но b-то у нас всё равно const, как же тогда это может работать?!?
    // Но всё просто - неизменяемость b относится к самому b (то есть к той самой паре указатель+длина),
    // но не к данным, на которые он показывает, а показывает он на var a, то есть на что-то мутабельное/изменяемое.
}
