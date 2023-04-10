import Foundation

public struct StaticArray27<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T)

    private var values: Values

    public init(values: Values) {
        self.values = values
    }

    public init(repeating value: T) {
        self.values = (
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value
        )
    }

    init(array: [T]) {
        guard array.count == 27 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1],
            array[2],
            array[3],
            array[4],
            array[5],
            array[6],
            array[7],
            array[8],
            array[9],
            array[10],
            array[11],
            array[12],
            array[13],
            array[14],
            array[15],
            array[16],
            array[17],
            array[18],
            array[19],
            array[20],
            array[21],
            array[22],
            array[23],
            array[24],
            array[25],
            array[26]
        )
    }

    public subscript(_ index: Int) -> T {
        get {
            switch index {
            case 0: return self.values.0
            case 1: return self.values.1
            case 2: return self.values.2
            case 3: return self.values.3
            case 4: return self.values.4
            case 5: return self.values.5
            case 6: return self.values.6
            case 7: return self.values.7
            case 8: return self.values.8
            case 9: return self.values.9
            case 10: return self.values.10
            case 11: return self.values.11
            case 12: return self.values.12
            case 13: return self.values.13
            case 14: return self.values.14
            case 15: return self.values.15
            case 16: return self.values.16
            case 17: return self.values.17
            case 18: return self.values.18
            case 19: return self.values.19
            case 20: return self.values.20
            case 21: return self.values.21
            case 22: return self.values.22
            case 23: return self.values.23
            case 24: return self.values.24
            case 25: return self.values.25
            case 26: return self.values.26
            default: fatalError("index out of range")
            }
        }
        set {
            switch index {
            case 0: self.values.0 = newValue
            case 1: self.values.1 = newValue
            case 2: self.values.2 = newValue
            case 3: self.values.3 = newValue
            case 4: self.values.4 = newValue
            case 5: self.values.5 = newValue
            case 6: self.values.6 = newValue
            case 7: self.values.7 = newValue
            case 8: self.values.8 = newValue
            case 9: self.values.9 = newValue
            case 10: self.values.10 = newValue
            case 11: self.values.11 = newValue
            case 12: self.values.12 = newValue
            case 13: self.values.13 = newValue
            case 14: self.values.14 = newValue
            case 15: self.values.15 = newValue
            case 16: self.values.16 = newValue
            case 17: self.values.17 = newValue
            case 18: self.values.18 = newValue
            case 19: self.values.19 = newValue
            case 20: self.values.20 = newValue
            case 21: self.values.21 = newValue
            case 22: self.values.22 = newValue
            case 23: self.values.23 = newValue
            case 24: self.values.24 = newValue
            case 25: self.values.25 = newValue
            case 26: self.values.26 = newValue
            default: fatalError("index out of range")
            }
        }
    }

    @inlinable public func get2(from offset: Int = 0) ->  StaticArray2<T> {
        switch offset {
         case 0:
            return StaticArray2(values: (
                self[0],
                self[1]
            ))
         case 1:
            return StaticArray2(values: (
                self[1],
                self[2]
            ))
         case 2:
            return StaticArray2(values: (
                self[2],
                self[3]
            ))
         case 3:
            return StaticArray2(values: (
                self[3],
                self[4]
            ))
         case 4:
            return StaticArray2(values: (
                self[4],
                self[5]
            ))
         case 5:
            return StaticArray2(values: (
                self[5],
                self[6]
            ))
         case 6:
            return StaticArray2(values: (
                self[6],
                self[7]
            ))
         case 7:
            return StaticArray2(values: (
                self[7],
                self[8]
            ))
         case 8:
            return StaticArray2(values: (
                self[8],
                self[9]
            ))
         case 9:
            return StaticArray2(values: (
                self[9],
                self[10]
            ))
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
            ))
         case 11:
            return StaticArray2(values: (
                self[11],
                self[12]
            ))
         case 12:
            return StaticArray2(values: (
                self[12],
                self[13]
            ))
         case 13:
            return StaticArray2(values: (
                self[13],
                self[14]
            ))
         case 14:
            return StaticArray2(values: (
                self[14],
                self[15]
            ))
         case 15:
            return StaticArray2(values: (
                self[15],
                self[16]
            ))
         case 16:
            return StaticArray2(values: (
                self[16],
                self[17]
            ))
         case 17:
            return StaticArray2(values: (
                self[17],
                self[18]
            ))
         case 18:
            return StaticArray2(values: (
                self[18],
                self[19]
            ))
         case 19:
            return StaticArray2(values: (
                self[19],
                self[20]
            ))
         case 20:
            return StaticArray2(values: (
                self[20],
                self[21]
            ))
         case 21:
            return StaticArray2(values: (
                self[21],
                self[22]
            ))
         case 22:
            return StaticArray2(values: (
                self[22],
                self[23]
            ))
         case 23:
            return StaticArray2(values: (
                self[23],
                self[24]
            ))
         case 24:
            return StaticArray2(values: (
                self[24],
                self[25]
            ))
         case 25:
            return StaticArray2(values: (
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get3(from offset: Int = 0) ->  StaticArray3<T> {
        switch offset {
         case 0:
            return StaticArray3(values: (
                self[0],
                self[1],
                self[2]
            ))
         case 1:
            return StaticArray3(values: (
                self[1],
                self[2],
                self[3]
            ))
         case 2:
            return StaticArray3(values: (
                self[2],
                self[3],
                self[4]
            ))
         case 3:
            return StaticArray3(values: (
                self[3],
                self[4],
                self[5]
            ))
         case 4:
            return StaticArray3(values: (
                self[4],
                self[5],
                self[6]
            ))
         case 5:
            return StaticArray3(values: (
                self[5],
                self[6],
                self[7]
            ))
         case 6:
            return StaticArray3(values: (
                self[6],
                self[7],
                self[8]
            ))
         case 7:
            return StaticArray3(values: (
                self[7],
                self[8],
                self[9]
            ))
         case 8:
            return StaticArray3(values: (
                self[8],
                self[9],
                self[10]
            ))
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
            ))
         case 10:
            return StaticArray3(values: (
                self[10],
                self[11],
                self[12]
            ))
         case 11:
            return StaticArray3(values: (
                self[11],
                self[12],
                self[13]
            ))
         case 12:
            return StaticArray3(values: (
                self[12],
                self[13],
                self[14]
            ))
         case 13:
            return StaticArray3(values: (
                self[13],
                self[14],
                self[15]
            ))
         case 14:
            return StaticArray3(values: (
                self[14],
                self[15],
                self[16]
            ))
         case 15:
            return StaticArray3(values: (
                self[15],
                self[16],
                self[17]
            ))
         case 16:
            return StaticArray3(values: (
                self[16],
                self[17],
                self[18]
            ))
         case 17:
            return StaticArray3(values: (
                self[17],
                self[18],
                self[19]
            ))
         case 18:
            return StaticArray3(values: (
                self[18],
                self[19],
                self[20]
            ))
         case 19:
            return StaticArray3(values: (
                self[19],
                self[20],
                self[21]
            ))
         case 20:
            return StaticArray3(values: (
                self[20],
                self[21],
                self[22]
            ))
         case 21:
            return StaticArray3(values: (
                self[21],
                self[22],
                self[23]
            ))
         case 22:
            return StaticArray3(values: (
                self[22],
                self[23],
                self[24]
            ))
         case 23:
            return StaticArray3(values: (
                self[23],
                self[24],
                self[25]
            ))
         case 24:
            return StaticArray3(values: (
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get4(from offset: Int = 0) ->  StaticArray4<T> {
        switch offset {
         case 0:
            return StaticArray4(values: (
                self[0],
                self[1],
                self[2],
                self[3]
            ))
         case 1:
            return StaticArray4(values: (
                self[1],
                self[2],
                self[3],
                self[4]
            ))
         case 2:
            return StaticArray4(values: (
                self[2],
                self[3],
                self[4],
                self[5]
            ))
         case 3:
            return StaticArray4(values: (
                self[3],
                self[4],
                self[5],
                self[6]
            ))
         case 4:
            return StaticArray4(values: (
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 5:
            return StaticArray4(values: (
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 6:
            return StaticArray4(values: (
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 7:
            return StaticArray4(values: (
                self[7],
                self[8],
                self[9],
                self[10]
            ))
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 9:
            return StaticArray4(values: (
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 10:
            return StaticArray4(values: (
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 11:
            return StaticArray4(values: (
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 12:
            return StaticArray4(values: (
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 13:
            return StaticArray4(values: (
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 14:
            return StaticArray4(values: (
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 15:
            return StaticArray4(values: (
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 16:
            return StaticArray4(values: (
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 17:
            return StaticArray4(values: (
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 18:
            return StaticArray4(values: (
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 19:
            return StaticArray4(values: (
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 20:
            return StaticArray4(values: (
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 21:
            return StaticArray4(values: (
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 22:
            return StaticArray4(values: (
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 23:
            return StaticArray4(values: (
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get5(from offset: Int = 0) ->  StaticArray5<T> {
        switch offset {
         case 0:
            return StaticArray5(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4]
            ))
         case 1:
            return StaticArray5(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5]
            ))
         case 2:
            return StaticArray5(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6]
            ))
         case 3:
            return StaticArray5(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 4:
            return StaticArray5(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 5:
            return StaticArray5(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 6:
            return StaticArray5(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 8:
            return StaticArray5(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 9:
            return StaticArray5(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 10:
            return StaticArray5(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 11:
            return StaticArray5(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 12:
            return StaticArray5(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 13:
            return StaticArray5(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 14:
            return StaticArray5(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 15:
            return StaticArray5(values: (
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 16:
            return StaticArray5(values: (
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 17:
            return StaticArray5(values: (
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 18:
            return StaticArray5(values: (
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 19:
            return StaticArray5(values: (
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 20:
            return StaticArray5(values: (
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 21:
            return StaticArray5(values: (
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 22:
            return StaticArray5(values: (
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get6(from offset: Int = 0) ->  StaticArray6<T> {
        switch offset {
         case 0:
            return StaticArray6(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5]
            ))
         case 1:
            return StaticArray6(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6]
            ))
         case 2:
            return StaticArray6(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 3:
            return StaticArray6(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 4:
            return StaticArray6(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 5:
            return StaticArray6(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 7:
            return StaticArray6(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 8:
            return StaticArray6(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 9:
            return StaticArray6(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 10:
            return StaticArray6(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 11:
            return StaticArray6(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 12:
            return StaticArray6(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 13:
            return StaticArray6(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 14:
            return StaticArray6(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 15:
            return StaticArray6(values: (
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 16:
            return StaticArray6(values: (
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 17:
            return StaticArray6(values: (
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 18:
            return StaticArray6(values: (
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 19:
            return StaticArray6(values: (
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 20:
            return StaticArray6(values: (
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 21:
            return StaticArray6(values: (
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get7(from offset: Int = 0) ->  StaticArray7<T> {
        switch offset {
         case 0:
            return StaticArray7(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6]
            ))
         case 1:
            return StaticArray7(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 2:
            return StaticArray7(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 3:
            return StaticArray7(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 4:
            return StaticArray7(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 6:
            return StaticArray7(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 7:
            return StaticArray7(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 8:
            return StaticArray7(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 9:
            return StaticArray7(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 10:
            return StaticArray7(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 11:
            return StaticArray7(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 12:
            return StaticArray7(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 13:
            return StaticArray7(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 14:
            return StaticArray7(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 15:
            return StaticArray7(values: (
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 16:
            return StaticArray7(values: (
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 17:
            return StaticArray7(values: (
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 18:
            return StaticArray7(values: (
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 19:
            return StaticArray7(values: (
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 20:
            return StaticArray7(values: (
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get8(from offset: Int = 0) ->  StaticArray8<T> {
        switch offset {
         case 0:
            return StaticArray8(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 1:
            return StaticArray8(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 2:
            return StaticArray8(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 3:
            return StaticArray8(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 5:
            return StaticArray8(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 6:
            return StaticArray8(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 7:
            return StaticArray8(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 8:
            return StaticArray8(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 9:
            return StaticArray8(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 10:
            return StaticArray8(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 11:
            return StaticArray8(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 12:
            return StaticArray8(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 13:
            return StaticArray8(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 14:
            return StaticArray8(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 15:
            return StaticArray8(values: (
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 16:
            return StaticArray8(values: (
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 17:
            return StaticArray8(values: (
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 18:
            return StaticArray8(values: (
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 19:
            return StaticArray8(values: (
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get9(from offset: Int = 0) ->  StaticArray9<T> {
        switch offset {
         case 0:
            return StaticArray9(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 1:
            return StaticArray9(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 2:
            return StaticArray9(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 4:
            return StaticArray9(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 5:
            return StaticArray9(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 6:
            return StaticArray9(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 7:
            return StaticArray9(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 8:
            return StaticArray9(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 9:
            return StaticArray9(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 10:
            return StaticArray9(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 11:
            return StaticArray9(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 12:
            return StaticArray9(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 13:
            return StaticArray9(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 14:
            return StaticArray9(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 15:
            return StaticArray9(values: (
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 16:
            return StaticArray9(values: (
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 17:
            return StaticArray9(values: (
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 18:
            return StaticArray9(values: (
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get10(from offset: Int = 0) ->  StaticArray10<T> {
        switch offset {
         case 0:
            return StaticArray10(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 1:
            return StaticArray10(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 3:
            return StaticArray10(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 4:
            return StaticArray10(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 5:
            return StaticArray10(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 6:
            return StaticArray10(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 7:
            return StaticArray10(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 8:
            return StaticArray10(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 9:
            return StaticArray10(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 10:
            return StaticArray10(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 11:
            return StaticArray10(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 12:
            return StaticArray10(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 13:
            return StaticArray10(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 14:
            return StaticArray10(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 15:
            return StaticArray10(values: (
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 16:
            return StaticArray10(values: (
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 17:
            return StaticArray10(values: (
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 2:
            return StaticArray11(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 3:
            return StaticArray11(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 4:
            return StaticArray11(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 5:
            return StaticArray11(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 6:
            return StaticArray11(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 7:
            return StaticArray11(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 8:
            return StaticArray11(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 9:
            return StaticArray11(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 10:
            return StaticArray11(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 11:
            return StaticArray11(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 12:
            return StaticArray11(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 13:
            return StaticArray11(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 14:
            return StaticArray11(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 15:
            return StaticArray11(values: (
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 16:
            return StaticArray11(values: (
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get12(from offset: Int = 0) ->  StaticArray12<T> {
        switch offset {
         case 0:
            return StaticArray12(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 1:
            return StaticArray12(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 2:
            return StaticArray12(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 3:
            return StaticArray12(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 4:
            return StaticArray12(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 5:
            return StaticArray12(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 6:
            return StaticArray12(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 7:
            return StaticArray12(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 8:
            return StaticArray12(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 9:
            return StaticArray12(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 10:
            return StaticArray12(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 11:
            return StaticArray12(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 12:
            return StaticArray12(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 13:
            return StaticArray12(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 14:
            return StaticArray12(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 15:
            return StaticArray12(values: (
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get13(from offset: Int = 0) ->  StaticArray13<T> {
        switch offset {
         case 0:
            return StaticArray13(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 1:
            return StaticArray13(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 2:
            return StaticArray13(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 3:
            return StaticArray13(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 4:
            return StaticArray13(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 5:
            return StaticArray13(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 6:
            return StaticArray13(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 7:
            return StaticArray13(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 8:
            return StaticArray13(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 9:
            return StaticArray13(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 10:
            return StaticArray13(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 11:
            return StaticArray13(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 12:
            return StaticArray13(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 13:
            return StaticArray13(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 14:
            return StaticArray13(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get14(from offset: Int = 0) ->  StaticArray14<T> {
        switch offset {
         case 0:
            return StaticArray14(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 1:
            return StaticArray14(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 2:
            return StaticArray14(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 3:
            return StaticArray14(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 4:
            return StaticArray14(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 5:
            return StaticArray14(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 6:
            return StaticArray14(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 7:
            return StaticArray14(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 8:
            return StaticArray14(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 9:
            return StaticArray14(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 10:
            return StaticArray14(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 11:
            return StaticArray14(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 12:
            return StaticArray14(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 13:
            return StaticArray14(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get15(from offset: Int = 0) ->  StaticArray15<T> {
        switch offset {
         case 0:
            return StaticArray15(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 1:
            return StaticArray15(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 2:
            return StaticArray15(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 3:
            return StaticArray15(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 4:
            return StaticArray15(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 5:
            return StaticArray15(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 6:
            return StaticArray15(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 7:
            return StaticArray15(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 8:
            return StaticArray15(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 9:
            return StaticArray15(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 10:
            return StaticArray15(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 11:
            return StaticArray15(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 12:
            return StaticArray15(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get16(from offset: Int = 0) ->  StaticArray16<T> {
        switch offset {
         case 0:
            return StaticArray16(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 1:
            return StaticArray16(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 2:
            return StaticArray16(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 3:
            return StaticArray16(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 4:
            return StaticArray16(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 5:
            return StaticArray16(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 6:
            return StaticArray16(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 7:
            return StaticArray16(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 8:
            return StaticArray16(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 9:
            return StaticArray16(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 10:
            return StaticArray16(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 11:
            return StaticArray16(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get17(from offset: Int = 0) ->  StaticArray17<T> {
        switch offset {
         case 0:
            return StaticArray17(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 1:
            return StaticArray17(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 2:
            return StaticArray17(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 3:
            return StaticArray17(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 4:
            return StaticArray17(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 5:
            return StaticArray17(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 6:
            return StaticArray17(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 7:
            return StaticArray17(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 8:
            return StaticArray17(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 9:
            return StaticArray17(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 10:
            return StaticArray17(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get18(from offset: Int = 0) ->  StaticArray18<T> {
        switch offset {
         case 0:
            return StaticArray18(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 1:
            return StaticArray18(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 2:
            return StaticArray18(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 3:
            return StaticArray18(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 4:
            return StaticArray18(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 5:
            return StaticArray18(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 6:
            return StaticArray18(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 7:
            return StaticArray18(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 8:
            return StaticArray18(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 9:
            return StaticArray18(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get19(from offset: Int = 0) ->  StaticArray19<T> {
        switch offset {
         case 0:
            return StaticArray19(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 1:
            return StaticArray19(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 2:
            return StaticArray19(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 3:
            return StaticArray19(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 4:
            return StaticArray19(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 5:
            return StaticArray19(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 6:
            return StaticArray19(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 7:
            return StaticArray19(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 8:
            return StaticArray19(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get20(from offset: Int = 0) ->  StaticArray20<T> {
        switch offset {
         case 0:
            return StaticArray20(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
         case 1:
            return StaticArray20(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 2:
            return StaticArray20(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 3:
            return StaticArray20(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 4:
            return StaticArray20(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 5:
            return StaticArray20(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 6:
            return StaticArray20(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 7:
            return StaticArray20(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get21(from offset: Int = 0) ->  StaticArray21<T> {
        switch offset {
         case 0:
            return StaticArray21(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20]
            ))
         case 1:
            return StaticArray21(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 2:
            return StaticArray21(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 3:
            return StaticArray21(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 4:
            return StaticArray21(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 5:
            return StaticArray21(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 6:
            return StaticArray21(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get22(from offset: Int = 0) ->  StaticArray22<T> {
        switch offset {
         case 0:
            return StaticArray22(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21]
            ))
         case 1:
            return StaticArray22(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 2:
            return StaticArray22(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 3:
            return StaticArray22(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 4:
            return StaticArray22(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 5:
            return StaticArray22(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get23(from offset: Int = 0) ->  StaticArray23<T> {
        switch offset {
         case 0:
            return StaticArray23(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22]
            ))
         case 1:
            return StaticArray23(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 2:
            return StaticArray23(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 3:
            return StaticArray23(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 4:
            return StaticArray23(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get24(from offset: Int = 0) ->  StaticArray24<T> {
        switch offset {
         case 0:
            return StaticArray24(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23]
            ))
         case 1:
            return StaticArray24(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 2:
            return StaticArray24(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 3:
            return StaticArray24(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get25(from offset: Int = 0) ->  StaticArray25<T> {
        switch offset {
         case 0:
            return StaticArray25(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24]
            ))
         case 1:
            return StaticArray25(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 2:
            return StaticArray25(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get26(from offset: Int = 0) ->  StaticArray26<T> {
        switch offset {
         case 0:
            return StaticArray26(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25]
            ))
         case 1:
            return StaticArray26(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19],
                self[20],
                self[21],
                self[22],
                self[23],
                self[24],
                self[25],
                self[26]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set2(_ array: StaticArray2<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
         case 18:
            self[18] = array[0]
            self[19] = array[1]
         case 19:
            self[19] = array[0]
            self[20] = array[1]
         case 20:
            self[20] = array[0]
            self[21] = array[1]
         case 21:
            self[21] = array[0]
            self[22] = array[1]
         case 22:
            self[22] = array[0]
            self[23] = array[1]
         case 23:
            self[23] = array[0]
            self[24] = array[1]
         case 24:
            self[24] = array[0]
            self[25] = array[1]
         case 25:
            self[25] = array[0]
            self[26] = array[1]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set3(_ array: StaticArray3<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
            self[19] = array[2]
         case 18:
            self[18] = array[0]
            self[19] = array[1]
            self[20] = array[2]
         case 19:
            self[19] = array[0]
            self[20] = array[1]
            self[21] = array[2]
         case 20:
            self[20] = array[0]
            self[21] = array[1]
            self[22] = array[2]
         case 21:
            self[21] = array[0]
            self[22] = array[1]
            self[23] = array[2]
         case 22:
            self[22] = array[0]
            self[23] = array[1]
            self[24] = array[2]
         case 23:
            self[23] = array[0]
            self[24] = array[1]
            self[25] = array[2]
         case 24:
            self[24] = array[0]
            self[25] = array[1]
            self[26] = array[2]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set4(_ array: StaticArray4<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
            self[19] = array[3]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
            self[19] = array[2]
            self[20] = array[3]
         case 18:
            self[18] = array[0]
            self[19] = array[1]
            self[20] = array[2]
            self[21] = array[3]
         case 19:
            self[19] = array[0]
            self[20] = array[1]
            self[21] = array[2]
            self[22] = array[3]
         case 20:
            self[20] = array[0]
            self[21] = array[1]
            self[22] = array[2]
            self[23] = array[3]
         case 21:
            self[21] = array[0]
            self[22] = array[1]
            self[23] = array[2]
            self[24] = array[3]
         case 22:
            self[22] = array[0]
            self[23] = array[1]
            self[24] = array[2]
            self[25] = array[3]
         case 23:
            self[23] = array[0]
            self[24] = array[1]
            self[25] = array[2]
            self[26] = array[3]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set5(_ array: StaticArray5<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
            self[19] = array[4]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
            self[19] = array[3]
            self[20] = array[4]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
            self[19] = array[2]
            self[20] = array[3]
            self[21] = array[4]
         case 18:
            self[18] = array[0]
            self[19] = array[1]
            self[20] = array[2]
            self[21] = array[3]
            self[22] = array[4]
         case 19:
            self[19] = array[0]
            self[20] = array[1]
            self[21] = array[2]
            self[22] = array[3]
            self[23] = array[4]
         case 20:
            self[20] = array[0]
            self[21] = array[1]
            self[22] = array[2]
            self[23] = array[3]
            self[24] = array[4]
         case 21:
            self[21] = array[0]
            self[22] = array[1]
            self[23] = array[2]
            self[24] = array[3]
            self[25] = array[4]
         case 22:
            self[22] = array[0]
            self[23] = array[1]
            self[24] = array[2]
            self[25] = array[3]
            self[26] = array[4]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set6(_ array: StaticArray6<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
            self[19] = array[5]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
            self[19] = array[4]
            self[20] = array[5]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
            self[19] = array[3]
            self[20] = array[4]
            self[21] = array[5]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
            self[19] = array[2]
            self[20] = array[3]
            self[21] = array[4]
            self[22] = array[5]
         case 18:
            self[18] = array[0]
            self[19] = array[1]
            self[20] = array[2]
            self[21] = array[3]
            self[22] = array[4]
            self[23] = array[5]
         case 19:
            self[19] = array[0]
            self[20] = array[1]
            self[21] = array[2]
            self[22] = array[3]
            self[23] = array[4]
            self[24] = array[5]
         case 20:
            self[20] = array[0]
            self[21] = array[1]
            self[22] = array[2]
            self[23] = array[3]
            self[24] = array[4]
            self[25] = array[5]
         case 21:
            self[21] = array[0]
            self[22] = array[1]
            self[23] = array[2]
            self[24] = array[3]
            self[25] = array[4]
            self[26] = array[5]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set7(_ array: StaticArray7<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
            self[19] = array[6]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
            self[19] = array[5]
            self[20] = array[6]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
            self[19] = array[4]
            self[20] = array[5]
            self[21] = array[6]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
            self[19] = array[3]
            self[20] = array[4]
            self[21] = array[5]
            self[22] = array[6]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
            self[19] = array[2]
            self[20] = array[3]
            self[21] = array[4]
            self[22] = array[5]
            self[23] = array[6]
         case 18:
            self[18] = array[0]
            self[19] = array[1]
            self[20] = array[2]
            self[21] = array[3]
            self[22] = array[4]
            self[23] = array[5]
            self[24] = array[6]
         case 19:
            self[19] = array[0]
            self[20] = array[1]
            self[21] = array[2]
            self[22] = array[3]
            self[23] = array[4]
            self[24] = array[5]
            self[25] = array[6]
         case 20:
            self[20] = array[0]
            self[21] = array[1]
            self[22] = array[2]
            self[23] = array[3]
            self[24] = array[4]
            self[25] = array[5]
            self[26] = array[6]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set8(_ array: StaticArray8<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
            self[19] = array[7]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
            self[19] = array[6]
            self[20] = array[7]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
            self[19] = array[5]
            self[20] = array[6]
            self[21] = array[7]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
            self[19] = array[4]
            self[20] = array[5]
            self[21] = array[6]
            self[22] = array[7]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
            self[19] = array[3]
            self[20] = array[4]
            self[21] = array[5]
            self[22] = array[6]
            self[23] = array[7]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
            self[19] = array[2]
            self[20] = array[3]
            self[21] = array[4]
            self[22] = array[5]
            self[23] = array[6]
            self[24] = array[7]
         case 18:
            self[18] = array[0]
            self[19] = array[1]
            self[20] = array[2]
            self[21] = array[3]
            self[22] = array[4]
            self[23] = array[5]
            self[24] = array[6]
            self[25] = array[7]
         case 19:
            self[19] = array[0]
            self[20] = array[1]
            self[21] = array[2]
            self[22] = array[3]
            self[23] = array[4]
            self[24] = array[5]
            self[25] = array[6]
            self[26] = array[7]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set9(_ array: StaticArray9<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
            self[19] = array[8]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
            self[19] = array[7]
            self[20] = array[8]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
            self[19] = array[6]
            self[20] = array[7]
            self[21] = array[8]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
            self[19] = array[5]
            self[20] = array[6]
            self[21] = array[7]
            self[22] = array[8]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
            self[19] = array[4]
            self[20] = array[5]
            self[21] = array[6]
            self[22] = array[7]
            self[23] = array[8]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
            self[19] = array[3]
            self[20] = array[4]
            self[21] = array[5]
            self[22] = array[6]
            self[23] = array[7]
            self[24] = array[8]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
            self[19] = array[2]
            self[20] = array[3]
            self[21] = array[4]
            self[22] = array[5]
            self[23] = array[6]
            self[24] = array[7]
            self[25] = array[8]
         case 18:
            self[18] = array[0]
            self[19] = array[1]
            self[20] = array[2]
            self[21] = array[3]
            self[22] = array[4]
            self[23] = array[5]
            self[24] = array[6]
            self[25] = array[7]
            self[26] = array[8]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set10(_ array: StaticArray10<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
            self[19] = array[9]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
            self[19] = array[8]
            self[20] = array[9]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
            self[19] = array[7]
            self[20] = array[8]
            self[21] = array[9]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
            self[19] = array[6]
            self[20] = array[7]
            self[21] = array[8]
            self[22] = array[9]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
            self[19] = array[5]
            self[20] = array[6]
            self[21] = array[7]
            self[22] = array[8]
            self[23] = array[9]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
            self[19] = array[4]
            self[20] = array[5]
            self[21] = array[6]
            self[22] = array[7]
            self[23] = array[8]
            self[24] = array[9]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
            self[19] = array[3]
            self[20] = array[4]
            self[21] = array[5]
            self[22] = array[6]
            self[23] = array[7]
            self[24] = array[8]
            self[25] = array[9]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
            self[19] = array[2]
            self[20] = array[3]
            self[21] = array[4]
            self[22] = array[5]
            self[23] = array[6]
            self[24] = array[7]
            self[25] = array[8]
            self[26] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
            self[19] = array[10]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
            self[19] = array[9]
            self[20] = array[10]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
            self[19] = array[8]
            self[20] = array[9]
            self[21] = array[10]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
            self[19] = array[7]
            self[20] = array[8]
            self[21] = array[9]
            self[22] = array[10]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
            self[19] = array[6]
            self[20] = array[7]
            self[21] = array[8]
            self[22] = array[9]
            self[23] = array[10]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
            self[19] = array[5]
            self[20] = array[6]
            self[21] = array[7]
            self[22] = array[8]
            self[23] = array[9]
            self[24] = array[10]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
            self[19] = array[4]
            self[20] = array[5]
            self[21] = array[6]
            self[22] = array[7]
            self[23] = array[8]
            self[24] = array[9]
            self[25] = array[10]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
            self[19] = array[3]
            self[20] = array[4]
            self[21] = array[5]
            self[22] = array[6]
            self[23] = array[7]
            self[24] = array[8]
            self[25] = array[9]
            self[26] = array[10]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set12(_ array: StaticArray12<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
            self[19] = array[11]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
            self[19] = array[10]
            self[20] = array[11]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
            self[19] = array[9]
            self[20] = array[10]
            self[21] = array[11]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
            self[19] = array[8]
            self[20] = array[9]
            self[21] = array[10]
            self[22] = array[11]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
            self[19] = array[7]
            self[20] = array[8]
            self[21] = array[9]
            self[22] = array[10]
            self[23] = array[11]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
            self[19] = array[6]
            self[20] = array[7]
            self[21] = array[8]
            self[22] = array[9]
            self[23] = array[10]
            self[24] = array[11]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
            self[19] = array[5]
            self[20] = array[6]
            self[21] = array[7]
            self[22] = array[8]
            self[23] = array[9]
            self[24] = array[10]
            self[25] = array[11]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
            self[19] = array[4]
            self[20] = array[5]
            self[21] = array[6]
            self[22] = array[7]
            self[23] = array[8]
            self[24] = array[9]
            self[25] = array[10]
            self[26] = array[11]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set13(_ array: StaticArray13<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
            self[19] = array[12]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
            self[19] = array[11]
            self[20] = array[12]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
            self[19] = array[10]
            self[20] = array[11]
            self[21] = array[12]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
            self[19] = array[9]
            self[20] = array[10]
            self[21] = array[11]
            self[22] = array[12]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
            self[19] = array[8]
            self[20] = array[9]
            self[21] = array[10]
            self[22] = array[11]
            self[23] = array[12]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
            self[19] = array[7]
            self[20] = array[8]
            self[21] = array[9]
            self[22] = array[10]
            self[23] = array[11]
            self[24] = array[12]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
            self[19] = array[6]
            self[20] = array[7]
            self[21] = array[8]
            self[22] = array[9]
            self[23] = array[10]
            self[24] = array[11]
            self[25] = array[12]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
            self[19] = array[5]
            self[20] = array[6]
            self[21] = array[7]
            self[22] = array[8]
            self[23] = array[9]
            self[24] = array[10]
            self[25] = array[11]
            self[26] = array[12]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set14(_ array: StaticArray14<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
            self[19] = array[13]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
            self[19] = array[12]
            self[20] = array[13]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
            self[19] = array[11]
            self[20] = array[12]
            self[21] = array[13]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
            self[19] = array[10]
            self[20] = array[11]
            self[21] = array[12]
            self[22] = array[13]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
            self[19] = array[9]
            self[20] = array[10]
            self[21] = array[11]
            self[22] = array[12]
            self[23] = array[13]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
            self[19] = array[8]
            self[20] = array[9]
            self[21] = array[10]
            self[22] = array[11]
            self[23] = array[12]
            self[24] = array[13]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
            self[19] = array[7]
            self[20] = array[8]
            self[21] = array[9]
            self[22] = array[10]
            self[23] = array[11]
            self[24] = array[12]
            self[25] = array[13]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
            self[19] = array[6]
            self[20] = array[7]
            self[21] = array[8]
            self[22] = array[9]
            self[23] = array[10]
            self[24] = array[11]
            self[25] = array[12]
            self[26] = array[13]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set15(_ array: StaticArray15<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
            self[19] = array[14]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
            self[19] = array[13]
            self[20] = array[14]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
            self[19] = array[12]
            self[20] = array[13]
            self[21] = array[14]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
            self[19] = array[11]
            self[20] = array[12]
            self[21] = array[13]
            self[22] = array[14]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
            self[19] = array[10]
            self[20] = array[11]
            self[21] = array[12]
            self[22] = array[13]
            self[23] = array[14]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
            self[19] = array[9]
            self[20] = array[10]
            self[21] = array[11]
            self[22] = array[12]
            self[23] = array[13]
            self[24] = array[14]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
            self[19] = array[8]
            self[20] = array[9]
            self[21] = array[10]
            self[22] = array[11]
            self[23] = array[12]
            self[24] = array[13]
            self[25] = array[14]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
            self[19] = array[7]
            self[20] = array[8]
            self[21] = array[9]
            self[22] = array[10]
            self[23] = array[11]
            self[24] = array[12]
            self[25] = array[13]
            self[26] = array[14]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set16(_ array: StaticArray16<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
            self[19] = array[15]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
            self[19] = array[14]
            self[20] = array[15]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
            self[19] = array[13]
            self[20] = array[14]
            self[21] = array[15]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
            self[19] = array[12]
            self[20] = array[13]
            self[21] = array[14]
            self[22] = array[15]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
            self[19] = array[11]
            self[20] = array[12]
            self[21] = array[13]
            self[22] = array[14]
            self[23] = array[15]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
            self[19] = array[10]
            self[20] = array[11]
            self[21] = array[12]
            self[22] = array[13]
            self[23] = array[14]
            self[24] = array[15]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
            self[19] = array[9]
            self[20] = array[10]
            self[21] = array[11]
            self[22] = array[12]
            self[23] = array[13]
            self[24] = array[14]
            self[25] = array[15]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
            self[19] = array[8]
            self[20] = array[9]
            self[21] = array[10]
            self[22] = array[11]
            self[23] = array[12]
            self[24] = array[13]
            self[25] = array[14]
            self[26] = array[15]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set17(_ array: StaticArray17<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
            self[19] = array[16]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
            self[19] = array[15]
            self[20] = array[16]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
            self[19] = array[14]
            self[20] = array[15]
            self[21] = array[16]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
            self[19] = array[13]
            self[20] = array[14]
            self[21] = array[15]
            self[22] = array[16]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
            self[19] = array[12]
            self[20] = array[13]
            self[21] = array[14]
            self[22] = array[15]
            self[23] = array[16]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
            self[19] = array[11]
            self[20] = array[12]
            self[21] = array[13]
            self[22] = array[14]
            self[23] = array[15]
            self[24] = array[16]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
            self[19] = array[10]
            self[20] = array[11]
            self[21] = array[12]
            self[22] = array[13]
            self[23] = array[14]
            self[24] = array[15]
            self[25] = array[16]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
            self[19] = array[9]
            self[20] = array[10]
            self[21] = array[11]
            self[22] = array[12]
            self[23] = array[13]
            self[24] = array[14]
            self[25] = array[15]
            self[26] = array[16]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set18(_ array: StaticArray18<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
            self[19] = array[17]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
            self[19] = array[16]
            self[20] = array[17]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
            self[19] = array[15]
            self[20] = array[16]
            self[21] = array[17]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
            self[19] = array[14]
            self[20] = array[15]
            self[21] = array[16]
            self[22] = array[17]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
            self[19] = array[13]
            self[20] = array[14]
            self[21] = array[15]
            self[22] = array[16]
            self[23] = array[17]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
            self[19] = array[12]
            self[20] = array[13]
            self[21] = array[14]
            self[22] = array[15]
            self[23] = array[16]
            self[24] = array[17]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
            self[19] = array[11]
            self[20] = array[12]
            self[21] = array[13]
            self[22] = array[14]
            self[23] = array[15]
            self[24] = array[16]
            self[25] = array[17]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
            self[19] = array[10]
            self[20] = array[11]
            self[21] = array[12]
            self[22] = array[13]
            self[23] = array[14]
            self[24] = array[15]
            self[25] = array[16]
            self[26] = array[17]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set19(_ array: StaticArray19<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
            self[18] = array[18]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
            self[19] = array[18]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
            self[19] = array[17]
            self[20] = array[18]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
            self[19] = array[16]
            self[20] = array[17]
            self[21] = array[18]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
            self[19] = array[15]
            self[20] = array[16]
            self[21] = array[17]
            self[22] = array[18]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
            self[19] = array[14]
            self[20] = array[15]
            self[21] = array[16]
            self[22] = array[17]
            self[23] = array[18]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
            self[19] = array[13]
            self[20] = array[14]
            self[21] = array[15]
            self[22] = array[16]
            self[23] = array[17]
            self[24] = array[18]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
            self[19] = array[12]
            self[20] = array[13]
            self[21] = array[14]
            self[22] = array[15]
            self[23] = array[16]
            self[24] = array[17]
            self[25] = array[18]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
            self[19] = array[11]
            self[20] = array[12]
            self[21] = array[13]
            self[22] = array[14]
            self[23] = array[15]
            self[24] = array[16]
            self[25] = array[17]
            self[26] = array[18]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set20(_ array: StaticArray20<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
            self[18] = array[18]
            self[19] = array[19]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
            self[19] = array[18]
            self[20] = array[19]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
            self[19] = array[17]
            self[20] = array[18]
            self[21] = array[19]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
            self[19] = array[16]
            self[20] = array[17]
            self[21] = array[18]
            self[22] = array[19]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
            self[19] = array[15]
            self[20] = array[16]
            self[21] = array[17]
            self[22] = array[18]
            self[23] = array[19]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
            self[19] = array[14]
            self[20] = array[15]
            self[21] = array[16]
            self[22] = array[17]
            self[23] = array[18]
            self[24] = array[19]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
            self[19] = array[13]
            self[20] = array[14]
            self[21] = array[15]
            self[22] = array[16]
            self[23] = array[17]
            self[24] = array[18]
            self[25] = array[19]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
            self[19] = array[12]
            self[20] = array[13]
            self[21] = array[14]
            self[22] = array[15]
            self[23] = array[16]
            self[24] = array[17]
            self[25] = array[18]
            self[26] = array[19]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set21(_ array: StaticArray21<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
            self[18] = array[18]
            self[19] = array[19]
            self[20] = array[20]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
            self[19] = array[18]
            self[20] = array[19]
            self[21] = array[20]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
            self[19] = array[17]
            self[20] = array[18]
            self[21] = array[19]
            self[22] = array[20]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
            self[19] = array[16]
            self[20] = array[17]
            self[21] = array[18]
            self[22] = array[19]
            self[23] = array[20]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
            self[19] = array[15]
            self[20] = array[16]
            self[21] = array[17]
            self[22] = array[18]
            self[23] = array[19]
            self[24] = array[20]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
            self[19] = array[14]
            self[20] = array[15]
            self[21] = array[16]
            self[22] = array[17]
            self[23] = array[18]
            self[24] = array[19]
            self[25] = array[20]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
            self[19] = array[13]
            self[20] = array[14]
            self[21] = array[15]
            self[22] = array[16]
            self[23] = array[17]
            self[24] = array[18]
            self[25] = array[19]
            self[26] = array[20]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set22(_ array: StaticArray22<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
            self[18] = array[18]
            self[19] = array[19]
            self[20] = array[20]
            self[21] = array[21]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
            self[19] = array[18]
            self[20] = array[19]
            self[21] = array[20]
            self[22] = array[21]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
            self[19] = array[17]
            self[20] = array[18]
            self[21] = array[19]
            self[22] = array[20]
            self[23] = array[21]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
            self[19] = array[16]
            self[20] = array[17]
            self[21] = array[18]
            self[22] = array[19]
            self[23] = array[20]
            self[24] = array[21]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
            self[19] = array[15]
            self[20] = array[16]
            self[21] = array[17]
            self[22] = array[18]
            self[23] = array[19]
            self[24] = array[20]
            self[25] = array[21]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
            self[19] = array[14]
            self[20] = array[15]
            self[21] = array[16]
            self[22] = array[17]
            self[23] = array[18]
            self[24] = array[19]
            self[25] = array[20]
            self[26] = array[21]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set23(_ array: StaticArray23<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
            self[18] = array[18]
            self[19] = array[19]
            self[20] = array[20]
            self[21] = array[21]
            self[22] = array[22]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
            self[19] = array[18]
            self[20] = array[19]
            self[21] = array[20]
            self[22] = array[21]
            self[23] = array[22]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
            self[19] = array[17]
            self[20] = array[18]
            self[21] = array[19]
            self[22] = array[20]
            self[23] = array[21]
            self[24] = array[22]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
            self[19] = array[16]
            self[20] = array[17]
            self[21] = array[18]
            self[22] = array[19]
            self[23] = array[20]
            self[24] = array[21]
            self[25] = array[22]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
            self[19] = array[15]
            self[20] = array[16]
            self[21] = array[17]
            self[22] = array[18]
            self[23] = array[19]
            self[24] = array[20]
            self[25] = array[21]
            self[26] = array[22]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set24(_ array: StaticArray24<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
            self[18] = array[18]
            self[19] = array[19]
            self[20] = array[20]
            self[21] = array[21]
            self[22] = array[22]
            self[23] = array[23]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
            self[19] = array[18]
            self[20] = array[19]
            self[21] = array[20]
            self[22] = array[21]
            self[23] = array[22]
            self[24] = array[23]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
            self[19] = array[17]
            self[20] = array[18]
            self[21] = array[19]
            self[22] = array[20]
            self[23] = array[21]
            self[24] = array[22]
            self[25] = array[23]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
            self[19] = array[16]
            self[20] = array[17]
            self[21] = array[18]
            self[22] = array[19]
            self[23] = array[20]
            self[24] = array[21]
            self[25] = array[22]
            self[26] = array[23]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set25(_ array: StaticArray25<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
            self[18] = array[18]
            self[19] = array[19]
            self[20] = array[20]
            self[21] = array[21]
            self[22] = array[22]
            self[23] = array[23]
            self[24] = array[24]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
            self[19] = array[18]
            self[20] = array[19]
            self[21] = array[20]
            self[22] = array[21]
            self[23] = array[22]
            self[24] = array[23]
            self[25] = array[24]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
            self[19] = array[17]
            self[20] = array[18]
            self[21] = array[19]
            self[22] = array[20]
            self[23] = array[21]
            self[24] = array[22]
            self[25] = array[23]
            self[26] = array[24]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set26(_ array: StaticArray26<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
            self[18] = array[18]
            self[19] = array[19]
            self[20] = array[20]
            self[21] = array[21]
            self[22] = array[22]
            self[23] = array[23]
            self[24] = array[24]
            self[25] = array[25]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
            self[19] = array[18]
            self[20] = array[19]
            self[21] = array[20]
            self[22] = array[21]
            self[23] = array[22]
            self[24] = array[23]
            self[25] = array[24]
            self[26] = array[25]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public  func toArray() -> [T] {
        [
            self[0],
            self[1],
            self[2],
            self[3],
            self[4],
            self[5],
            self[6],
            self[7],
            self[8],
            self[9],
            self[10],
            self[11],
            self[12],
            self[13],
            self[14],
            self[15],
            self[16],
            self[17],
            self[18],
            self[19],
            self[20],
            self[21],
            self[22],
            self[23],
            self[24],
            self[25],
            self[26]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray27<M> {
        try StaticArray27<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2]),
            transform(self[3]),
            transform(self[4]),
            transform(self[5]),
            transform(self[6]),
            transform(self[7]),
            transform(self[8]),
            transform(self[9]),
            transform(self[10]),
            transform(self[11]),
            transform(self[12]),
            transform(self[13]),
            transform(self[14]),
            transform(self[15]),
            transform(self[16]),
            transform(self[17]),
            transform(self[18]),
            transform(self[19]),
            transform(self[20]),
            transform(self[21]),
            transform(self[22]),
            transform(self[23]),
            transform(self[24]),
            transform(self[25]),
            transform(self[26])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray27<L>, _ rhs: StaticArray27<R>) -> StaticArray27<(L, R)> {
    StaticArray27(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2]),
        (lhs[3], rhs[3]),
        (lhs[4], rhs[4]),
        (lhs[5], rhs[5]),
        (lhs[6], rhs[6]),
        (lhs[7], rhs[7]),
        (lhs[8], rhs[8]),
        (lhs[9], rhs[9]),
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11]),
        (lhs[12], rhs[12]),
        (lhs[13], rhs[13]),
        (lhs[14], rhs[14]),
        (lhs[15], rhs[15]),
        (lhs[16], rhs[16]),
        (lhs[17], rhs[17]),
        (lhs[18], rhs[18]),
        (lhs[19], rhs[19]),
        (lhs[20], rhs[20]),
        (lhs[21], rhs[21]),
        (lhs[22], rhs[22]),
        (lhs[23], rhs[23]),
        (lhs[24], rhs[24]),
        (lhs[25], rhs[25]),
        (lhs[26], rhs[26])
    ))
}

extension StaticArray27: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 27 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray27: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray27<T>

        init(_ array: StaticArray27<T>) {
            self.array = array
        }

        public mutating func next() -> T? {
            guard self.index < self.array.count else { return nil }
            let value = self.array[self.index]
            self.index += 1
            return value
        }
    }

    public func makeIterator() -> Iterator {
        Iterator(self)
    }
}

extension StaticArray27: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray27: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray27: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray27<T>, rhs: T) -> StaticArray27<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray27<T>) -> StaticArray27<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray27<T>, rhs: T) -> StaticArray27<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray27<T>) -> StaticArray27<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray27: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray27<T>, rhs: T) -> StaticArray27<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray27<T>) -> StaticArray27<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray27: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray27<T>, rhs: T) -> StaticArray27<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray27<T>) -> StaticArray27<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray27: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

