--!A cross-platform build utility based on Lua
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
-- Copyright (C) 2015 - 2019, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        check_cfuncs.lua
--

-- check c funcs and add macro definition 
--
-- the function syntax
--  - sigsetjmp
--  - sigsetjmp((void*)0, 0)
--  - sigsetjmp{sigsetjmp((void*)0, 0);}
--  - sigsetjmp{int a = 0; sigsetjmp((void*)a, a);}
--
-- e.g.
--
-- check_cfuncs("HAS_SETJMP", "setjmp", {includes = {"signal.h", "setjmp.h"}, links = {}})
-- check_cfuncs("HAS_SETJMP", {"setjmp", "sigsetjmp{sigsetjmp((void*)0, 0);}"})
--
function check_cfuncs(definition, funcs, opt)
    opt = opt or {}
    option(opt.name or definition)
        add_cfuncs(funcs)
        add_defines(definition)
        if opt.links then
            add_links(opt.links)
        end
        if opt.includes then
            add_cincludes(opt.includes)
        end
        if opt.languages then
            set_languages(opt.languages)
        end
        if opt.cflags then
            add_cflags(opt.cflags)
        end
        if opt.cflags then
            add_cxflags(opt.cxflags)
        end
    option_end()
    add_options(opt.name or definition)
end

-- check c funcs and add macro definition to the configuration files 
--
-- e.g.
--
-- configvar_check_cfuncs("HAS_SETJMP", "setjmp", {includes = {"signal.h", "setjmp.h"}, links = {}})
-- configvar_check_cfuncs("HAS_SETJMP", {"setjmp", "sigsetjmp{sigsetjmp((void*)0, 0);}"})
--
function configvar_check_cfuncs(definition, funcs, opt)
    opt = opt or {}
    option(opt.name or definition)
        add_cfuncs(funcs)
        set_configvar(definition, 1)
        if opt.links then
            add_links(opt.links)
        end
        if opt.includes then
            add_cincludes(opt.includes)
        end
        if opt.languages then
            set_languages(opt.languages)
        end
        if opt.cflags then
            add_cflags(opt.cflags)
        end
        if opt.cxflags then
            add_cxflags(opt.cxflags)
        end
    option_end()
    add_options(opt.name or definition)
end
