TimedList = {}
TimedList.__index = TimedList

function TimedList:New(compareFunction)

  local o = {
    _compareFunction = compareFunction,
    _table={},
  }
  setmetatable(o, self)
  return o
end


TimedList.Add = function(self, object, expireSecs)

  local record = {
    Object = object,
    AddedTime = os.clock (),
    ExpiresAt = expireSecs + os.clock (),
  }
  self:Remove(object)
  table.insert(self._table,record)
end


TimedList.Contains = function(self, object)
  for k,v in ipairs(self._table) do
    if self._compareFunction ~= nil and self._compareFunction(v.Object, object) == true
      or self._compareFunction == nil and v.Object == object then
      if v.ExpiresAt <= os.clock () then
        self:Remove(object)
        return false
      end
      return true
    end
  end

  return false

end

TimedList.Find = function(self, object)
  for k,v in ipairs(self._table) do
    if self._compareFunction ~= nil and self._compareFunction(v.Object, object) == true
      or self._compareFunction == nil and v.Object == object then
      if v.ExpiresAt <= os.clock () then
        self:Remove(object)
        return nil
      end
      return v
    end
  end

  return nil

end


TimedList.Remove = function(self, object)

  for i=1, #self._table, 1 do
    if self._compareFunction ~= nil and self._compareFunction(self._table[i].Object, object) == true
      or self._compareFunction == nil and self._table[i].Object == object then
      table.remove(self._table,i)
      return
    end
  end

end
