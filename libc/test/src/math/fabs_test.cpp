//===-- Unittests for fabs ------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "include/math.h"
#include "src/math/fabs.h"
#include "utils/FPUtil/BitPatterns.h"
#include "utils/FPUtil/FloatOperations.h"
#include "utils/FPUtil/FloatProperties.h"
#include "utils/MPFRWrapper/MPFRUtils.h"
#include "utils/UnitTest/Test.h"

using __llvm_libc::fputil::valueAsBits;
using __llvm_libc::fputil::valueFromBits;

using BitPatterns = __llvm_libc::fputil::BitPatterns<double>;
using Properties = __llvm_libc::fputil::FloatProperties<double>;

namespace mpfr = __llvm_libc::testing::mpfr;

// Zero tolerance; As in, exact match with MPFR result.
static constexpr mpfr::Tolerance tolerance{mpfr::Tolerance::doublePrecision, 0,
                                           0};

TEST(FabsTest, SpecialNumbers) {
  EXPECT_EQ(
      BitPatterns::aQuietNaN,
      valueAsBits(__llvm_libc::fabs(valueFromBits(BitPatterns::aQuietNaN))));
  EXPECT_EQ(BitPatterns::aQuietNaN, valueAsBits(__llvm_libc::fabs(valueFromBits(
                                        BitPatterns::aNegativeQuietNaN))));

  EXPECT_EQ(BitPatterns::aSignallingNaN,
            valueAsBits(
                __llvm_libc::fabs(valueFromBits(BitPatterns::aSignallingNaN))));
  EXPECT_EQ(BitPatterns::aSignallingNaN,
            valueAsBits(__llvm_libc::fabs(
                valueFromBits(BitPatterns::aNegativeSignallingNaN))));

  EXPECT_EQ(BitPatterns::inf,
            valueAsBits(__llvm_libc::fabs(valueFromBits(BitPatterns::inf))));
  EXPECT_EQ(BitPatterns::inf,
            valueAsBits(__llvm_libc::fabs(valueFromBits(BitPatterns::negInf))));

  EXPECT_EQ(BitPatterns::zero,
            valueAsBits(__llvm_libc::fabs(valueFromBits(BitPatterns::zero))));
  EXPECT_EQ(BitPatterns::zero, valueAsBits(__llvm_libc::fabs(
                                   valueFromBits(BitPatterns::negZero))));
}

TEST(FabsTest, InDoubleRange) {
  using BitsType = Properties::BitsType;
  constexpr BitsType count = 1000000;
  constexpr BitsType step = UINT64_MAX / count;
  for (BitsType i = 0, v = 0; i <= count; ++i, v += step) {
    double x = valueFromBits(v);
    if (isnan(x) || isinf(x))
      continue;
    ASSERT_MPFR_MATCH(mpfr::OP_Abs, x, __llvm_libc::fabs(x), tolerance);
  }
}
