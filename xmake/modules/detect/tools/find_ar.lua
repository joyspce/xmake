--!The Make-like Build Utility based on Lua
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- 
-- Copyright (C) 2015 - 2017, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        find_ar.lua
--

-- imports
import("core.tool.compiler")
import("lib.detect.find_program")

-- check
function _check(program)

    -- make an stub source file
    local libraryfile   = os.tmpfile() .. ".a"
    local objectfile    = os.tmpfile() .. ".o"
    local sourcefile    = os.tmpfile() .. ".c"
    io.writefile(sourcefile, "int test(void)\n{return 0;}")

    -- compile it
    compiler.compile(sourcefile, objectfile)

    -- archive it
    os.runv(program, {"-cr", libraryfile, objectfile})

    -- remove files
    os.rm(objectfile)
    os.rm(sourcefile)
    os.rm(libraryfile)
end

-- find ar
--
-- @param opt   the argument options, .e.g {version = true}
--
-- @return      program, version
--
-- @code 
--
-- local ar = find_ar()
-- local ar, version = find_ar({program = "xcrun -sdk macosx g++", version = true})
-- 
-- @endcode
--
function main(opt)

    -- init options
    opt = opt or {}

    -- find program
    return find_program(opt.program or "ar", opt.pathes, opt.check or _check)
end