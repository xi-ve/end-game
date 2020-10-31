---@class ByteBuffer
local ByteBuffer = {}

---Creates a new by ByteBuffer with the given length
---@param length integer
---@return ByteBuffer byteBuffer
function ByteBuffer(length)
end

---@type integer
ByteBuffer.size = nil

---Returns the current read position in the ByteBuffer
---@return integer position
function ByteBuffer:getReadPos()
end
---Returns the current write position in the ByteBuffer
---@return integer position
function ByteBuffer:getWritePos()
end
---Sets the read position to a new position
---@param newPos integer
function ByteBuffer:setReadPos(newPos)
end
---Sets the write position to a new position
---@param newPos integer
function ByteBuffer:setWritePos(newPos)
end

---Reads a file and puts its content in the ByteBuffer
---@param filePath string
function ByteBuffer:fromFile(filePath)
end

---Creates a copy of the ByteBuffer
---@return ByteBuffer copy
function ByteBuffer:clone()
end

---Moves the reader position forward by a given amount
---@param count integer
function ByteBuffer:skip(count)
end

---Returns the underlying array as a table.
---@return table data
function ByteBuffer:getBuffer()
end

---Returns the byte at the reader position and moves the reader pointer forward by 1 byte.
---@return integer byteValue
function ByteBuffer:get()
end
---Returns the byte at a specific position in the buffer
---@param index integer
---@return integer byteValue
function ByteBuffer:_get(index)
end

---Returns the wstring (2 byte per character) at the reader position terminated by a null byte and moves the reader pointer forward by the string lengths byte.
---@return string string
function ByteBuffer:getWString()
end
---Returns the wstring (2 byte per character) at a specific position in the buffer terminated by a null byte
---@param index integer
---@return string string
function ByteBuffer:_getWString(index)
end

---Returns the string at the reader position terminated by a null byte and moves the reader pointer forward by the string lengths byte.
---@return string string
function ByteBuffer:getString()
end

---Returns the string at a specific position in the buffer terminated by a null byte
---@param index integer
---@return string string
function ByteBuffer:_getString(index)
end

---Returns the char at the reader position and moves the reader pointer forward by 1 byte. 
---@return integer charValue
function ByteBuffer:getChar()
end
---Returns the char at a specific position in the buffer
---@param index integer
---@return integer charValue
function ByteBuffer:_getChar(index)
end

---Returns the double at the reader position and moves the reader pointer forward by 8 byte. 
---@return integer charValue
function ByteBuffer:getDouble()
end
---Returns the double at a specific position in the buffer
---@param index integer
---@return number dValue
function ByteBuffer:_getDouble(index)
end

---Returns the float at the reader position and moves the reader pointer forward by 4 byte. 
---@return integer charValue
function ByteBuffer:getFloat()
end
---Returns the float at a specific position in the buffer
---@param index integer
---@return number fValue
function ByteBuffer:_getFloat(index)
end

---Returns the integer at the reader position and moves the reader pointer forward by 4 byte. 
---@return integer iValue
function ByteBuffer:getInt()
end
---Returns the integer at a specific position in the buffer
---@param index integer
---@return integer iValue
function ByteBuffer:_getInt(index)
end
---Returns the unsigned integer at the reader position and moves the reader pointer forward by 4 byte. 
---@return number iValue
function ByteBuffer:getUInt()
end
---Returns the unsigned integer at a specific position in the buffer
---@param index integer
---@return number iValue
function ByteBuffer:_getUInt(index)
end

---Returns the int64_t at the reader position and moves the reader pointer forward by 8 byte. 
---@return LuaInt64 iValue
function ByteBuffer:getLong()
end
---Returns the int64_t at a specific position in the buffer
---@param index integer
---@return LuaInt64 iValue
function ByteBuffer:_getLong(index)
end

---Returns the short at the reader position and moves the reader pointer forward by 2 byte. 
---@return integer iValue
function ByteBuffer:getShort()
end
---Returns the short at a specific position in the buffer
---@param index integer
---@return integer iValue
function ByteBuffer:_getShort(index)
end

---Writes the given byte to the current writer position and moves the write reader forward by 1 bytes
---@param value integer
function ByteBuffer:put(value)
end
---Writes the given byte to a given position
---@param value integer
---@param index integer
function ByteBuffer:_put(value, index)
end

---Writes the given bytes to the current writer position and moves the write reader forward by the given bytes
---@param value table
---@param length integer
function ByteBuffer:putBytes(value, length)
end
---Writes the given bytes to the given position
---@param value table
---@param length integer
---@param index integer
function ByteBuffer:_putBytes(value, length, index)
end

---Writes the given string as a wstring(2 bytes per character) to the current writer position and moves the write reader forward by the string lengths bytes
---@param data string
---@param length integer
function ByteBuffer:putWString(data, length)
end
---Writes the given string to the current writer position  and moves the write reader forward by the string lengths bytes
---@param data string
---@param length integer
function ByteBuffer:putString(data, length)
end

---Writes the given amount of empty bytes from the current writer position onwards and moves the writer position behind the empty bytes.
---@param count integer
function ByteBuffer:putEmptyBytes(count)
end

---Writes the given char to the current writer position and moves the write reader forward by 1 bytes
---@param value integer
function ByteBuffer:putChar(value)
end
---Writes the given char to a given position
---@param value integer
---@param index integer
function ByteBuffer:_putChar(value, index)
end

---Writes the given double to the current writer position and moves the write reader forward by 8 bytes
---@param value number
function ByteBuffer:putDouble(value)
end
---Writes the given double to a given position
---@param value number
---@param index integer
function ByteBuffer:_putDouble(value, index)
end

---Writes the given float to the current writer position and moves the write reader forward by 4 bytes
---@param value number
function ByteBuffer:putFloat(value)
end
---Writes the given float to a given position
---@param value number
---@param index integer
function ByteBuffer:_putFloat(value, index)
end

---Writes the given integer to the current writer position and moves the write reader forward by 4 bytes
---@param value integer
function ByteBuffer:putInt(value)
end
---Writes the given integer to a given position
---@param value integer
---@param index integer
function ByteBuffer:_putInt(value, index)
end

---Writes the given unsigned integer to the current writer position and moves the write reader forward by 4 bytes
---@param value number
function ByteBuffer:putUInt(value)
end
---Writes the given unsigned integer to a given position
---@param value number
---@param index integer
function ByteBuffer:_putUInt(value, index)
end

---Writes the given integer as a 8 byte long to the current writer position and moves the write reader forward by 8 bytes. Should also be able to handle uints
---@param value integer
function ByteBuffer:putIntAsLong(value)
end
---Writes the given integer as a 8 byte long to a given position. Should also be able to handle uints
---@param value integer
---@param index integer
function ByteBuffer:_putIntAsLong(value, index)
end

---Writes the given int64_t long to the current writer position and moves the write reader forward by 8 bytes.
---@param value LuaInt64
function ByteBuffer:putLuaInt64(value)
end
---Writes the int64_t long to a given position.
---@param value LuaInt64
---@param index integer
function ByteBuffer:_putLuaInt64(value, index)
end

---Writes the given short to the current writer position and moves the write reader forward by 2 bytes
---@param value integer
function ByteBuffer:putShort(value)
end
---Writes the given short to a given position
---@param value integer
---@param index integer
function ByteBuffer:_putShort(value, index)
end

---Writes the given amount of FF(255) bytes from the current writer position onwards and moves the writer position behind the FF bytes.
---@param amount integer
function ByteBuffer:putFF(amount)
end
-- Writes the given amount of FF(255) bytes to the given position
---@param amount integer
---@param index integer
function ByteBuffer:_putFF(amount, index)
end
