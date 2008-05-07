--[[
FFLuCI - SGI-Module for Haserl

Description:
Server Gateway Interface for Haserl

FileId:
$Id$

License:
Copyright 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at 

	http://www.apache.org/licenses/LICENSE-2.0 

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

]]--
module("ffluci.sgi.webuci", package.seeall)

-- Environment Table
ffluci.http.env = webuci.env


local status_set = false

-- Returns a table of all COOKIE, GET and POST Parameters
function ffluci.http.formvalues()
	return webuci.vars
end

-- Gets form value from key
function ffluci.http.formvalue(key, default)
	return ffluci.http.formvalues()[key] or default
end

-- Gets a table of values with a certain prefix
function ffluci.http.formvaluetable(prefix)
	local vals = {}
	prefix = prefix and prefix .. "." or "."
	
	for k, v in pairs(ffluci.http.formvalues()) do
		if k:find(prefix, 1, true) == 1 then
			vals[k:sub(#prefix + 1)] = v
		end
	end
	
	return vals
end


-- Set Content-Type
function ffluci.http.prepare_content(type)
	if not status_set then
		ffluci.http.status(200, "OK")
	end
	
	print("Content-Type: "..type.."\n")
end

-- Sets HTTP-Status-Header
function ffluci.http.status(code, message)
	print(webuci.env.SERVER_PROTOCOL .. " " .. tostring(code) .. " " .. message)
	status_set = true
end
