// Copyright 2026 It Just Crashed
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
// in compliance with the License. You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under the
// License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing permissions and
// limitations under the License.

#pragma once

/// An 8-bit signed integer.
typedef __INT8_TYPE__ i8;
/// A 16-bit signed integer.
typedef __INT16_TYPE__ i16;
/// A 32-bit signed integer.
typedef __INT32_TYPE__ i32;
/// A 64-bit signed integer.
typedef __INT64_TYPE__ i64;

/// An 8-bit unsigned integer.
typedef __UINT8_TYPE__ u8;
/// A 16-bit unsigned integer.
typedef __UINT16_TYPE__ u16;
/// A 32-bit unsigned integer.
typedef __UINT32_TYPE__ u32;
/// A 64-bit unsigned integer.
typedef __UINT64_TYPE__ u64;

/// An unsigned integer that is the same type as Clang's __SIZE_TYPE__.
typedef __SIZE_TYPE__ size;
