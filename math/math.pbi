XIncludeFile "_declare__math_.pbi"
DeclareModule math
  EnableExplicit  
  Macro GetType(nb)
(((TypeOf(nb\__type0__)&1)<<0) +((TypeOf(nb\__type1__)&1)<<1) +((TypeOf(nb\__type2__)&1)<<2) + ((TypeOf(nb\__type3__)&1)<<3))
    ;+ _math_::_typehelper2(nb,4) + _math_::_typehelper2(nb,5) + _math_::_typehelper2(nb,6) + _math_::_typehelper2(nb,7))
  EndMacro
;-----------------------
;- constants.pbi
;{

#epsilon            = 1.192092896e-07 ; float-Epsilon!
#zero               = 0
#one                = 1
#PI                 = 3.1415926535897932384
#two_pi             = 6.2831853071795864769
#root_pi            = 1.772453850905516027
#half_pi            = 1.5707963267948966192
#three_over_two_pi  = 4.7123889803846898577
#quarter_pi         = 0.7853981633974483096
#one_over_pi        = 0.3183098861837906715
#one_over_two_pi    = 0.1591549430918953358
#two_over_pi        = 0.6366197723675813431
#four_over_pi       = 1.2732395447351626862
#two_over_root_pi   = 1.1283791670955125739
#one_over_root_two  = 0.7071067811865475244
#root_half_pi       = 1.253314137315500251
#root_two_pi        = 2.506628274631000502
#root_ln_four       = 1.17741002251547469
#E                  = 2.7182818284590452354
#euler              = 0.5772156649015328606
#root_two           = 1.4142135623730950488
#root_three         = 1.7320508075688772935
#root_five          = 2.2360679774997896964
#ln_two             = 0.6931471805599453094
#ln_ten             = 2.3025850929940456840
#ln_ln_two          = -0.3665129205816643
#third              = 0.3333333333333333333
#two_thirds         = 0.6666666666666666667
#golden_ratio       = 1.6180339887498948482
#FLT_MIN            = 1.175494351e-38
#FLT_MAX            = 3.402823466e+38
#cos_one_over_two   = 0.8775825618903727161
;}
;-----------------------
;- vector.pbi
;{

;type must be smaller than 4!
Enumeration type
  #type_vec2 = 2
  #type_vec3 = 3
  #type_vec4 = 4
  #type_vecmax
EndEnumeration
Structure vec2
  _math_::StructureAddType(#type_vec2)
  StructureUnion
    x.f
    r.f
    s.f
    f.f[0]
  EndStructureUnion
  StructureUnion
    y.f
    g.f
    t.f
  EndStructureUnion
EndStructure
Structure vec3
  _math_::StructureAddType(#type_vec3)
  StructureUnion
    x.f
    r.f
    s.f
    f.f[0]
  EndStructureUnion
  StructureUnion
    y.f
    g.f
    t.f
  EndStructureUnion
  StructureUnion
    z.f
    b.f
    p.f
  EndStructureUnion
EndStructure
Structure vec4
  _math_::StructureAddType(#type_vec4)
  StructureUnion
    x.f
    r.f
    s.f
    f.f[0]
  EndStructureUnion
  StructureUnion
    y.f
    g.f
    t.f
  EndStructureUnion
  StructureUnion
    z.f
    b.f
    p.f
  EndStructureUnion
  StructureUnion
    w.f
    a.f
    q.f
  EndStructureUnion
EndStructure
Structure vec2l
  _math_::StructureAddType(#type_vec2)
  StructureUnion
    x.l
    r.l
    s.l
    l.l[0]
  EndStructureUnion
  StructureUnion
    y.l
    g.l
    t.l
  EndStructureUnion
EndStructure
Structure vec3l
  _math_::StructureAddType(#type_vec3)
  StructureUnion
    x.l
    r.l
    s.l
    l.l[0]
  EndStructureUnion
  StructureUnion
    y.l
    g.l
    t.l
  EndStructureUnion
  StructureUnion
    z.l
    b.l
    p.l
  EndStructureUnion
EndStructure
Structure vec4l
  _math_::StructureAddType(#type_vec4)
  StructureUnion
    x.l
    r.l
    s.l
    l.l[0]
  EndStructureUnion
  StructureUnion
    y.l
    g.l
    t.l
  EndStructureUnion
  StructureUnion
    z.l
    b.l
    p.l
  EndStructureUnion
  StructureUnion
    w.l
    a.l
    q.l
  EndStructureUnion
EndStructure
;}
;-----------------------
;- type_vector.pbi
;{

Macro vec2_set(res, xf=0.0, yf=0.0)
  res\x = xf
  res\y = yf
EndMacro
Macro vec2_const(label,xf,yf)
  DataSection
    label:
    Data.f xf, yf
  EndDataSection
EndMacro
Macro vec2_set_Scalar(res, s)
  res\x = (s)
  res\y = (s)
EndMacro
Macro vec2_set_vec2(res, v)
  res\x = v\x
  res\y = v\y
EndMacro
Macro vec2_set_vec3(res, v)
  res\x = v\x
  res\y = v\y
EndMacro
Macro vec2_set_vec4(res, v)
  res\x = v\x
  res\y = v\y
EndMacro
Macro vec2_let(res,v1, op, v2)
  res\x = v1\x op v2\x
  res\y = v1\y op v2\y
EndMacro
Macro vec2_let_Scalar(res, v, op, s)
  res\x = v\x op (s)
  res\y = v\y op (s)
EndMacro
Macro Scalar_let_vec2(res, s, op, v)
  res\x = (s) op v\x
  res\y = (s) op v\y 
EndMacro
Macro vec2_let_Func(res, func, v)
  res\x = func( v\x )
  res\y = func( v\y )
EndMacro
Macro vec2_let_Func2(res, func, v1, v2)
  res\x = func( v1\x, v2\x )
  res\y = func( v1\y, v2\y )
EndMacro
Macro vec2_let_Func2_Scalar(res, func, v1, s)
  res\x = func( v1\x, (s) )
  res\y = func( v1\y, (s) )
EndMacro
Macro vec2_isEqual(v1, v2)
  Bool(v1\x = v2\x And v1\y = v2\y)
EndMacro
Macro vec2_add(res, v1, v2)
res\x = v1\x + v2\x
res\y = v1\y + v2\y
EndMacro
Macro vec2_sub(res, v1, v2)
res\x = v1\x - v2\x
res\y = v1\y - v2\y
EndMacro
Macro vec2_mul(res, v1, v2)
res\x = v1\x * v2\x
res\y = v1\y * v2\y
EndMacro
Macro vec2_div(res, v1, v2)
res\x = v1\x / v2\x
res\y = v1\y / v2\y
EndMacro
Macro vec3_set(res, xf=0.0, yf=0.0, zf=0.0)
  res\x = xf
  res\y = yf
  res\z = zf
EndMacro
Macro vec3_const(label, xf, yf, zf)
  DataSection
    label:
    Data.f xf, yf, zf
  EndDataSection
EndMacro
Macro vec3_set_Scalar(res, s)
  res\x = (s)
  res\y = (s)
  res\z = (s)
EndMacro
Macro vec3_set_vec2_f(res, xy, zf)
  res\x = xy\x
  res\y = xy\y
  res\z = zf
EndMacro
Macro vec3_set_f_vec2(res, xf, yz)
  res\x = f
  res\y = yz\x
  res\z = yz\y
EndMacro
Macro vec3_set_vec3(res, v)
  res\x = v\x
  res\y = v\y
  res\z = v\z
EndMacro
Macro vec3_set_vec4(res, v)
  res\x = v\x
  res\y = v\y
  res\z = v\z
EndMacro
Macro vec3_let(res,v1, op, v2)
  res\x = v1\x op v2\x
  res\y = v1\y op v2\y
  res\z = v1\z op v2\z
EndMacro
Macro vec3_let_Scalar(res, v, op, s)
  res\x = v\x op (s)
  res\y = v\y op (s)
  res\z = v\z op (s)
EndMacro
Macro Scalar_let_vec3(res, s, op, v)
  res\x = (s) op v\x 
  res\y = (s) op v\y
  res\z = (s) op v\z
EndMacro
Macro vec3_let_Func(res, func, v)
  res\x = func( v\x )
  res\y = func( v\y )
  res\z = func( v\z )
EndMacro
Macro vec3_let_Func2(res, func, v1, v2)
  res\x = func( v1\x, v2\x )
  res\y = func( v1\y, v2\y )
  res\z = func( v1\z, v2\z )
EndMacro
Macro vec3_let_Func2_Scalar(res, func, v1, s)
  res\x = func( v1\x, (s) )
  res\y = func( v1\y, (s) )
  res\z = func( v1\z, (s) )
EndMacro
Macro vec3_isEqual(v1, v2)
  Bool(v1\x = v2\x And v1\y = v2\y And v1\z = v2\z)
EndMacro
Macro vec3_add(res, v1, v2)
res\x = v1\x + v2\x
res\y = v1\y + v2\y
res\z = v1\z + v2\z
EndMacro
Macro vec3_sub(res, v1, v2)
res\x = v1\x - v2\x
res\y = v1\y - v2\y
res\z = v1\z - v2\z
EndMacro
Macro vec3_mul(res, v1, v2)
res\x = v1\x * v2\x
res\y = v1\y * v2\y
res\z = v1\z * v2\z
EndMacro
Macro vec3_div(res, v1, v2)
res\x = v1\x / v2\x
res\y = v1\y / v2\y
res\z = v1\z / v2\z
EndMacro
Macro vec4_set(res, xf=0.0, yf=0.0, zf=0.0, wf=0.0)
  res\x = xf
  res\y = yf
  res\z = zf
  res\w = wf
EndMacro
Macro vec4_const(label, xf, yf, zf, wf)
  DataSection
    label:
    Data.f xf, yf, zf, wf
  EndDataSection
EndMacro
Macro vec4_set_Scalar(res, s)
  res\x = (s)
  res\y = (s)
  res\z = (s)
  res\w = (s)
EndMacro
Macro vec4_set_vec3_f(res, xyz, wf)
  res\x = xyz\x
  res\y = xyz\y
  res\z = xyz\z
  res\w = wf
EndMacro
Macro vec4_set_f_vec3(res, xf, yzw)
  res\x = f
  res\y = yz\x
  res\z = yz\y
  res\w = yz\z
EndMacro
Macro vec4_set_vec4(res, v)
  res\x = v\x
  res\y = v\y
  res\z = v\z
  res\w = v\w
EndMacro
Macro vec4_let(res,v1, op, v2)
  res\x = v1\x op v2\x
  res\y = v1\y op v2\y
  res\z = v1\z op v2\z
  res\w = v1\w op v2\w
EndMacro
Macro vec4_let_Scalar(res, v, op, s)
  res\x = v\x op (s)
  res\y = v\y op (s)
  res\z = v\z op (s)
  res\w = v\w op (s)
EndMacro
Macro Scalar_let_vec4(res, s, op, v)
  res\x = (s) op v\x 
  res\y = (s) op v\y 
  res\z = (s) op v\z 
  res\w = (s) op v\w 
EndMacro
Macro vec4_let_Func(res, func, v)
  res\x = func( v\x )
  res\y = func( v\y )
  res\z = func( v\z )
  res\w = func( v\w )
EndMacro
Macro vec4_let_Func2(res, func, v1, v2)
  res\x = func( v1\x, v2\x )
  res\y = func( v1\y, v2\y )
  res\z = func( v1\z, v2\z )
  res\w = func( v1\w, v2\w )
EndMacro
Macro vec4_let_Func2_scalar(res, func, v1, s)
  res\x = func( v1\x, (s) )
  res\y = func( v1\y, (s) )
  res\z = func( v1\z, (s) )
  res\w = func( v1\w, (s) )
EndMacro
Macro vec4_isEqual(v1, v2)
  Bool(v1\x = v2\x And v1\y = v2\y And v1\z = v2\z And v1\w = v2\w)
EndMacro
Macro vec4_add(res, v1, v2)
res\x = v1\x + v2\x
res\y = v1\y + v2\y
res\z = v1\z + v2\z
res\w = v1\w + v2\w
EndMacro
Macro vec4_sub(res, v1, v2)
res\x = v1\x - v2\x
res\y = v1\y - v2\y
res\z = v1\z - v2\z
res\w = v1\w - v2\w
EndMacro
Macro vec4_mul(res, v1, v2)
res\x = v1\x * v2\x
res\y = v1\y * v2\y
res\z = v1\z * v2\z
res\w = v1\w * v2\w
EndMacro
Macro vec4_div(res, v1, v2)
res\x = v1\x / v2\x
res\y = v1\y / v2\y
res\z = v1\z / v2\z
res\w = v1\w / v2\w
EndMacro
;}
;-----------------------
;- func_exponential.pbi
;{

Declare.f pow_f(a.f,b.f)
Declare.f exp_f(a.f)
Declare.f log_f(a.f)
Declare.f exp2_f(value.f)
Declare.f log2_f(value.f)
Declare.f sqrt_f(a.f)
Declare.f inversesqrt_f(f.f)
Macro inversesqrt(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
    CompilerError "[inversesqrt] quat not supported"
  CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@inversesqrt_f(), v)
EndMacro
Macro Pow(res, base, exponent)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(base\__type0__)&1)<<0) +((TypeOf(base\__type1__)&1)<<1) +((TypeOf(base\__type2__)&1)<<2) + ((TypeOf(base\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
    math::quat_pow(res, base, exponent)
  CompilerElse
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(base\__type0__)&1)<<0) +((TypeOf(base\__type1__)&1)<<1) +((TypeOf(base\__type2__)&1)<<2) + ((TypeOf(base\__type3__)&1)<<3)); when exponent is added, the compiler could crash
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@pow_f(), base, exponent)
  CompilerEndIf
EndMacro
Macro Exp(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
    math::quat_exp(res, x)
  CompilerElse
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@exp_f(), x)
  CompilerEndIf
EndMacro
Macro Log(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
    math::quat_Log(res, x)
  CompilerElse    
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@log_f(), x)
  CompilerEndIf
EndMacro
Macro Exp2(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
    CompilerError "[Exp2] quat not supported"
  CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@exp2_f(), x)
EndMacro
Macro Log2(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
    CompilerError "[Log2] quat not supported"
  CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@log2_f(), x)
EndMacro
Macro sqrt(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
    math::quat_sqrt(res, x)
  CompilerElse
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sqrt_f(), x)
  CompilerEndIf 
EndMacro
;}
;-----------------------
;- func_common.pbi
;{

Declare.f frexp_f(value.f, *exp.float)
Declare.f ldexp_f(x.f,expf.f)
Declare.f Modf_f(x.f, *retI.float)
Declare.f Mod_f(a.f, b.f)
Declare.f clamp_f(x.f, min.f=0, max.f=1)
Declare.f repeat_f(Texcoord.f)
Declare.f mirrorClamp_f(Texcoord.f)
Declare.f mirrorRepeat_f(Texcoord.f)
Declare.f Trunc_f(x.f)
Declare.f fract_f(x.f)
Declare.f mix_f(x.f, y.f, a.f)
Declare.f roundEven_f(x.f)
Declare.l equal_f(x.f,y.f,epsilon.f = #epsilon)
Declare.l notEqual_f(x.f,y.f,epsilon.f = #epsilon)
Declare.f Round_f(x.f)
Declare.f Floor_f(x.f)
Declare.f Ceil_f(x.f)
Declare.f Abs_f(x.f)
Declare.f sign_f(x.f)
Macro Modf(res, v, Resi)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) +((TypeOf(v\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(Resi\__type0__)&1)<<0) +((TypeOf(Resi\__type1__)&1)<<1) +((TypeOf(Resi\__type2__)&1)<<2) + ((TypeOf(Resi\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2p(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@modf_f(), v, Resi)
EndMacro
Macro frexp(res, v, Resi)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) +((TypeOf(v\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(Resi\__type0__)&1)<<0) +((TypeOf(Resi\__type1__)&1)<<1) +((TypeOf(Resi\__type2__)&1)<<2) + ((TypeOf(Resi\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2p(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@frexp_f(), v, Resi)
EndMacro
Macro ldexp(res, x, exp)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(exp\__type0__)&1)<<0) +((TypeOf(exp\__type1__)&1)<<1) +((TypeOf(exp\__type2__)&1)<<2) + ((TypeOf(exp\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@ldexp_f(), x, exp)
EndMacro
Macro Abs(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@abs_f(), x)
EndMacro
Macro Sign(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sign_f(), x)
EndMacro
Macro Floor(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@Floor_f(), x)
EndMacro
Macro Ceil(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@Ceil_f(), x)
EndMacro
Macro fract(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@fract_f(), x)
EndMacro
Macro roundEven(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@roundEven_f(), x)
EndMacro
Macro trunc(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@trunc_f(), x)
EndMacro
Macro Round(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@round_f(), x)
EndMacro
Macro Mod(res, x, y)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@mod_f(), x, y)
EndMacro
Macro Mod_Scalar(res, x, scalar)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2s(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@mod_f(), x, scalar)
EndMacro
Macro min(res, x, y)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), _math::@min2_f(), x, y)
EndMacro
Macro min_Scalar(res, x, scalar)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2s(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), _math::@min2_f(), x, scalar)
EndMacro
Macro max(res, x, y)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), _math::@max2_f(), x, y)
EndMacro
Macro max_Scalar(res, x, scalar)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2s(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), _math::@max2_f(), x, scalar)
EndMacro
Macro clamp(res, x, y, z)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) +((TypeOf(y\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(z\__type0__)&1)<<0) +((TypeOf(z\__type1__)&1)<<1) +((TypeOf(z\__type2__)&1)<<2) + ((TypeOf(z\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function3(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@clamp_f(), x, y, z)
EndMacro
Macro clamp_Scalar(res, x, min=0, max=1)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function3s(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@clamp_f(), x, min, max)
EndMacro
Macro Repeat(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@repeat_f(), x)
EndMacro
Macro mirrorClamp(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@repeat_f(), x)
EndMacro
Macro mirrorRepeat(res, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@repeat_f(), x)
EndMacro
Macro vec_Step(res, edge, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) > math::#type_vecmax
CompilerError "Type must be vector!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(edge\__type0__)&1)<<0) +((TypeOf(edge\__type1__)&1)<<1) +((TypeOf(edge\__type2__)&1)<<2) + ((TypeOf(edge\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::vec_Step_Vector(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), edge, x)
EndMacro
Macro vec_Step_Scalar(res, edgeScalar, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) > math::#type_vecmax
CompilerError "Type must be vector!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::vec_Step_Vector_Scalar(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), edgeScalar, x)
EndMacro
Macro smoothstep(res, edge0, edge1, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) > math::#type_vecmax
CompilerError "Type must be vector!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(edge0\__type0__)&1)<<0) +((TypeOf(edge0\__type1__)&1)<<1) +((TypeOf(edge0\__type2__)&1)<<2) +((TypeOf(edge0\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(edge1\__type0__)&1)<<0) +((TypeOf(edge1\__type1__)&1)<<1) +((TypeOf(edge1\__type2__)&1)<<2) + ((TypeOf(edge1\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::vec_smoothstep_vector(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), edge0, edge1, x)
EndMacro
Macro smoothstep_Scalar(res, edge0Scalar, edge1Scalar, x)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) > math::#type_vecmax
CompilerError "Type must be vector!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::vec_smoothstep_vector_Scalar(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), edge0Scalar, edge1Scalar, x)
EndMacro
Macro string(x,nbdecimals = 2)
_math::string(x,(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)), nbdecimals)
EndMacro
Macro stringBool(x)
_math::stringBool(x,(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)))
EndMacro
Macro IsNAN(resBool, x)
CompilerIf(((TypeOf(resbool\__type0__)&1)<<0) +((TypeOf(resbool\__type1__)&1)<<1) +((TypeOf(resbool\__type2__)&1)<<2) +((TypeOf(resbool\__type3__)&1)<<3)) =(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)) Or
((((TypeOf(resbool\__type0__)&1)<<0) +((TypeOf(resbool\__type1__)&1)<<1) +((TypeOf(resbool\__type2__)&1)<<2) +((TypeOf(resbool\__type3__)&1)<<3)) = math::#type_vec4 And(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)) = math::#type_quat)
_math::is_Nan(resbool,(((TypeOf(resbool\__type0__)&1)<<0) +((TypeOf(resbool\__type1__)&1)<<1) +((TypeOf(resbool\__type2__)&1)<<2) + ((TypeOf(resbool\__type3__)&1)<<3)), x)
  CompilerElse
    CompilerError "Type missmatch"
  CompilerEndIf
EndMacro
Macro isInf(resBool, x)
CompilerIf(((TypeOf(resbool\__type0__)&1)<<0) +((TypeOf(resbool\__type1__)&1)<<1) +((TypeOf(resbool\__type2__)&1)<<2) +((TypeOf(resbool\__type3__)&1)<<3)) =(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)) Or
((((TypeOf(resbool\__type0__)&1)<<0) +((TypeOf(resbool\__type1__)&1)<<1) +((TypeOf(resbool\__type2__)&1)<<2) +((TypeOf(resbool\__type3__)&1)<<3)) = math::#type_vec4 And(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)) = math::#type_quat)
_math::is_Inf(resbool,(((TypeOf(resbool\__type0__)&1)<<0) +((TypeOf(resbool\__type1__)&1)<<1) +((TypeOf(resbool\__type2__)&1)<<2) + ((TypeOf(resbool\__type3__)&1)<<3)), x)
  CompilerElse
    CompilerError "Type missmatch"
  CompilerEndIf
EndMacro
Macro any(bool)
_math::bool_any(bool,(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3)))
EndMacro
Macro all(bool)
_math::bool_all(bool,(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3)))
EndMacro
Macro Bool_not(resBool, Bool)
CompilerIf(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::Bool_not(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),bool)
EndMacro
Macro Bool_and(resBool, Bool)
CompilerIf(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::Bool_and(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),bool)
EndMacro
Macro Bool_or(resBool, Bool)
CompilerIf(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::Bool_or(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),bool)
EndMacro
Macro equal(resBool, x, y, epsilon = math::#epsilon)
CompilerIf(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::equal(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y,epsilon)
EndMacro
Macro notEqual(resBool, x, y, epsilon = math::#epsilon)
CompilerIf(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::notEqual(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y,epsilon)
EndMacro
Macro all_equal( x, y, epsilon = math::#epsilon)
_math::do_all(_math::@equal(),(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)),x,y,epsilon)
EndMacro
Macro any_notEqual( x, y, epsilon = math::#epsilon)
_math::do_any(_math::@notEqual(),(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)),x,y,epsilon)
EndMacro
Macro lessThan(resBool, x, y)
CompilerIf(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::lessThan(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y)
EndMacro
Macro lessThanEqual(resBool, x, y)
CompilerIf(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::lessThanEqual(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y)
EndMacro
Macro greaterThan(resBool, x, y)
CompilerIf(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::greaterThan(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y)
EndMacro
Macro greaterThanEqual(resBool, x, y)
CompilerIf(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) +((TypeOf(resBool\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::greaterThanEqual(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y)
EndMacro
Macro long_from_float(bool,matvec)
CompilerIf(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) +((TypeOf(bool\__type3__)&1)<<3)) <>(((TypeOf(matvec\__type0__)&1)<<0) +((TypeOf(matvec\__type1__)&1)<<1) +((TypeOf(matvec\__type2__)&1)<<2) + ((TypeOf(matvec\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::long_from_float(bool,(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3)),matvec)
EndMacro
Macro float_from_long(matvec, bool)
CompilerIf(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) +((TypeOf(bool\__type3__)&1)<<3)) <>(((TypeOf(matvec\__type0__)&1)<<0) +((TypeOf(matvec\__type1__)&1)<<1) +((TypeOf(matvec\__type2__)&1)<<2) + ((TypeOf(matvec\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::float_from_long(matvec,(((TypeOf(matvec\__type0__)&1)<<0) +((TypeOf(matvec\__type1__)&1)<<1) +((TypeOf(matvec\__type2__)&1)<<2) + ((TypeOf(matvec\__type3__)&1)<<3)), bool)
EndMacro
Macro mix_Scalar(res, x, y, A)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
    math::quat_mix(res, x, y, a)
  CompilerElse
_math::compute_mix_scalar(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), x, y, a)
  CompilerEndIf
EndMacro
Macro mix(res, x, y, A)  
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) +((TypeOf(y\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
    CompilerError "Quat only support mix_scalar"
  CompilerEndIf
_math::compute_mix(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), x, y, a)
EndMacro
Macro min_f(a,b,c=NaN(), d=NaN())
  _math::min_f(a,b,c,d)
EndMacro
Macro max_f(a,b,c=NaN(), d=NaN())
  _math::max_f(a,b,c,d)
EndMacro
;}
;-----------------------
;- func_geometric.pbi
;{

Declare Vec3_Cross(*res.vec3, *x.Vec3, *y.vec3)
Declare.f refract_f(i, n, eta)
Macro distance2(a, b)
_math::compute_distance2(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), b)
EndMacro
Macro distance(a, b)
Sqr(_math::compute_distance2(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), b))
EndMacro
Macro faceforward(res, n, i, nref)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(n\__type0__)&1)<<0) +((TypeOf(n\__type1__)&1)<<1) +((TypeOf(n\__type2__)&1)<<2) +((TypeOf(n\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(i\__type0__)&1)<<0) +((TypeOf(i\__type1__)&1)<<1) +((TypeOf(i\__type2__)&1)<<2) +((TypeOf(i\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(nref\__type0__)&1)<<0) +((TypeOf(nref\__type1__)&1)<<1) +((TypeOf(nref\__type2__)&1)<<2) + ((TypeOf(nref\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_faceforward(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), n, i, nref)
EndMacro
Macro reflect(res, i, n)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(i\__type0__)&1)<<0) +((TypeOf(i\__type1__)&1)<<1) +((TypeOf(i\__type2__)&1)<<2) +((TypeOf(i\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(n\__type0__)&1)<<0) +((TypeOf(n\__type1__)&1)<<1) +((TypeOf(n\__type2__)&1)<<2) + ((TypeOf(n\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_reflect(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), i, n)
EndMacro
Macro refract(res, I, N, eta)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(I\__type0__)&1)<<0) +((TypeOf(I\__type1__)&1)<<1) +((TypeOf(I\__type2__)&1)<<2) +((TypeOf(I\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(N\__type0__)&1)<<0) +((TypeOf(N\__type1__)&1)<<1) +((TypeOf(N\__type2__)&1)<<2) + ((TypeOf(N\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_refract(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), I, N, eta)
EndMacro
;}
;-----------------------
;- matrix.pbi
;{

Enumeration type
  #type_mat2x2 = #type_vecmax ; must be <= 8
  #type_mat3x2 
  #type_mat4x2 
  #type_mat2x3 ; must be <= 12
  #type_mat3x3 
  #type_mat4x3
  #type_mat2x4 ; must be <= 16
  #type_mat3x4 
  #type_mat4x4 
  #type_matMAX
EndEnumeration
CompilerIf #type_mat4x2 > SizeOf(vec2) Or #type_mat4x3 > SizeOf(vec3) Or #type_mat4x4 > SizeOf(vec4)
  CompilerError "TOBIG"
CompilerEndIf
;- Mat2x2
Structure Mat2x2
  _math_::StructureAddType(#type_mat2x2)
  StructureUnion
    column.vec2[2]
    value.vec2[2]
    v.vec2[2]
  EndStructureUnion
EndStructure
Structure Mat2x2L
  _math_::StructureAddType(#type_mat2x2)
  StructureUnion
    columnl.vec2L[2]
    valuel.vec2L[2]
    vl.vec2L[2]
  EndStructureUnion
EndStructure
;- Mat2x3
Structure Mat2x3
  _math_::StructureAddType(#type_mat2x3)
  StructureUnion
    column.vec3[2]
    value.vec3[2]
    v.vec3[2]
  EndStructureUnion
EndStructure
Structure Mat2x3L
  _math_::StructureAddType(#type_mat2x3)
  StructureUnion
    columnl.vec3L[2]
    valuel.vec3L[2]
    vl.vec3L[2]
  EndStructureUnion
EndStructure
;- Mat2x4
Structure Mat2x4
  _math_::StructureAddType(#type_mat2x4)
  StructureUnion
    column.vec4[2]
    value.vec4[2]
    v.vec4[2]
  EndStructureUnion
EndStructure
Structure Mat2x4L
  _math_::StructureAddType(#type_mat2x4)
  StructureUnion
    columnl.vec4L[2]
    valuel.vec4L[2]
    vl.vec4L[2]
  EndStructureUnion
EndStructure
;- Mat3x2
Structure Mat3x2
  _math_::StructureAddType(#type_mat3x2)
  StructureUnion    
    column.vec2[3]
    value.vec2[3]
    v.vec2[3]
  EndStructureUnion
EndStructure
Structure Mat3x2L
  _math_::StructureAddType(#type_mat3x2)
  StructureUnion
    columnl.vec2L[3]
    valuel.vec2L[3]
    vl.vec2L[3]
  EndStructureUnion
EndStructure
;- Mat3x3
Structure Mat3x3
  _math_::StructureAddType(#type_mat3x3)
  StructureUnion
    column.vec3[3]
    value.vec3[3]
    v.vec3[3]
  EndStructureUnion
EndStructure
Structure Mat3x3L
  _math_::StructureAddType(#type_mat3x3)
  StructureUnion
    columnl.vec3L[3]
    valuel.vec3L[3]
    vl.vec3L[3]
  EndStructureUnion
EndStructure
;- Mat3x4
Structure Mat3x4
  _math_::StructureAddType(#type_mat3x4)
  StructureUnion
    column.vec4[3]
    value.vec4[3]
    v.vec4[3]
  EndStructureUnion
EndStructure
Structure Mat3x4L
  _math_::StructureAddType(#type_mat3x4)
  StructureUnion
    columnl.vec4L[3]
    valuel.vec4L[3]
    vl.vec4L[3]
  EndStructureUnion
EndStructure
;- Mat4x2
Structure Mat4x2
  _math_::StructureAddType(#type_mat4x2)
  StructureUnion
    column.vec2[4]
    value.vec2[4]
    v.vec2[4]
  EndStructureUnion
EndStructure
Structure Mat4x2L
  _math_::StructureAddType(#type_mat4x2)
  StructureUnion
    columnl.vec2L[4]
    valuel.vec2L[4]
    vl.vec2L[4]
  EndStructureUnion
EndStructure
;- Mat4x3
Structure Mat4x3
  _math_::StructureAddType(#type_mat4x3)
  StructureUnion
    column.vec3[4]
    value.vec3[4]
    v.vec3[4]
  EndStructureUnion
EndStructure
Structure Mat4x3L
  _math_::StructureAddType(#type_mat4x3)
  StructureUnion
    columnl.vec3L[4]
    valuel.vec3L[4]
    vl.vec3L[4]
  EndStructureUnion
EndStructure
;- Mat4x4
Structure Mat4x4
  _math_::StructureAddType(#type_mat4x4)
  StructureUnion
    column.vec4[4]
    value.vec4[4]
    v.vec4[4]
  EndStructureUnion
EndStructure
Structure Mat4x4L
  _math_::StructureAddType(#type_mat4x4)
  StructureUnion
    columnl.vec4L[4]
    valuel.vec4L[4]
    vl.vec4L[4]
  EndStructureUnion
EndStructure
;}
;-----------------------
;- type_matrix.pbi
;{

;- Mat2x2
Macro Mat2x2_set (res, x0 = 1, y0 = 0, x1 = 0, y1 = 1)
res\column[0]\x = x0
res\column[0]\y = y0
res\column[1]\x = x1
res\column[1]\y = y1
EndMacro
Macro Mat2x2_set_Vec(res, v0, v1)
res\column[0]\x = v0\x
res\column[0]\y = v0\y
res\column[1]\x = v1\x
res\column[1]\y = v1\y
EndMacro
Macro Mat2x2_set_Mat2x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
EndMacro
Macro Mat2x2_set_Mat2x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
EndMacro
Macro Mat2x2_set_Mat2x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
EndMacro
Macro Mat2x2_set_Mat3x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
EndMacro
Macro Mat2x2_set_Mat3x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
EndMacro
Macro Mat2x2_set_Mat3x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
EndMacro
Macro Mat2x2_set_Mat4x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
EndMacro
Macro Mat2x2_set_Mat4x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
EndMacro
Macro Mat2x2_set_Mat4x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
EndMacro
Macro Mat2x2_set_Scalar(res, s)
res\column[0]\x = s
res\column[0]\y = 0.0
res\column[1]\x = 0.0
res\column[1]\y = s
EndMacro
Macro Mat2x2_let_Scalar(res, m, op, s)
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
EndMacro
Macro Scalar_let_Mat2x2(res, s, op, m)
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
EndMacro
Declare Mat2x2_add(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
Declare Mat2x2_sub(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
Declare Mat2x2_mul_Mat2x2(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
Declare Mat2x2_mul_Mat3x2(*res.Mat3x2, *m1.Mat2x2, *m2.Mat3x2)
Declare Mat2x2_mul_Mat4x2(*res.Mat4x2, *m1.Mat2x2, *m2.Mat4x2)
Declare Mat2x2_div(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
Declare Mat2x2_div_Vec2(*res.vec2, *m.Mat2x2, *v.vec2)
Declare Vec2_div_Mat2x2(*res.vec2, *v.vec2, *m.Mat2x2)
Declare Mat2x2_mul_Vec2(*vecres.Vec2, *m.Mat2x2, *v.Vec2)
Declare Vec2_mul_Mat2x2(*vecres.Vec2, *v.Vec2, *m.Mat2x2)
;- Mat2x3
Macro Mat2x3_set (res, x0 = 1, y0 = 0, z0 = 0, x1 = 0, y1 = 1, z1 = 0)
res\column[0]\x = x0
res\column[0]\y = y0
res\column[0]\z = z0
res\column[1]\x = x1
res\column[1]\y = y1
res\column[1]\z = z1
EndMacro
Macro Mat2x3_set_Vec(res, v0, v1)
res\column[0]\x = v0\x
res\column[0]\y = v0\y
res\column[0]\z = v0\z
res\column[1]\x = v1\x
res\column[1]\y = v1\y
res\column[1]\z = v1\z
EndMacro
Macro Mat2x3_set_Mat2x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
EndMacro
Macro Mat2x3_set_Mat2x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
EndMacro
Macro Mat2x3_set_Mat2x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
EndMacro
Macro Mat2x3_set_Mat3x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
EndMacro
Macro Mat2x3_set_Mat3x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
EndMacro
Macro Mat2x3_set_Mat3x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
EndMacro
Macro Mat2x3_set_Mat4x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
EndMacro
Macro Mat2x3_set_Mat4x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
EndMacro
Macro Mat2x3_set_Mat4x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
EndMacro
Macro Mat2x3_set_Scalar(res, s)
res\column[0]\x = s
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[1]\x = 0.0
res\column[1]\y = s
res\column[1]\z = 0.0
EndMacro
Macro Mat2x3_let_Scalar(res, m, op, s)
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
EndMacro
Macro Scalar_let_Mat2x3(res, s, op, m)
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
EndMacro
Declare Mat2x3_add(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x3)
Declare Mat2x3_sub(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x3)
Declare Mat2x3_mul_Mat2x2(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x2)
Declare Mat2x3_mul_Mat3x2(*res.Mat3x3, *m1.Mat2x3, *m2.Mat3x2)
Declare Mat2x3_mul_Mat4x2(*res.Mat4x3, *m1.Mat2x3, *m2.Mat4x2)
Declare Mat2x3_mul_Vec2(*vecres.Vec3, *m.Mat2x3, *v.Vec2)
Declare Vec3_mul_Mat2x3(*vecres.Vec2, *v.Vec3, *m.Mat2x3)
;- Mat2x4
Macro Mat2x4_set (res, x0 = 1, y0 = 0, z0 = 0, w0 = 0, x1 = 0, y1 = 1, z1 = 0, w1 = 0)
res\column[0]\x = x0
res\column[0]\y = y0
res\column[0]\z = z0
res\column[0]\w = w0
res\column[1]\x = x1
res\column[1]\y = y1
res\column[1]\z = z1
res\column[1]\w = w1
EndMacro
Macro Mat2x4_set_Vec(res, v0, v1)
res\column[0]\x = v0\x
res\column[0]\y = v0\y
res\column[0]\z = v0\z
res\column[0]\w = v0\w
res\column[1]\x = v1\x
res\column[1]\y = v1\y
res\column[1]\z = v1\z
res\column[1]\w = v1\w
EndMacro
Macro Mat2x4_set_Mat2x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
EndMacro
Macro Mat2x4_set_Mat2x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
EndMacro
Macro Mat2x4_set_Mat2x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
EndMacro
Macro Mat2x4_set_Mat3x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
EndMacro
Macro Mat2x4_set_Mat3x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
EndMacro
Macro Mat2x4_set_Mat3x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
EndMacro
Macro Mat2x4_set_Mat4x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
EndMacro
Macro Mat2x4_set_Mat4x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
EndMacro
Macro Mat2x4_set_Mat4x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
EndMacro
Macro Mat2x4_set_Scalar(res, s)
res\column[0]\x = s
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = 0.0
res\column[1]\y = s
res\column[1]\z = 0.0
res\column[1]\w = 0.0
EndMacro
Macro Mat2x4_let_Scalar(res, m, op, s)
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[0]\w = m\column[0]\w op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[1]\w = m\column[1]\w op(s)
EndMacro
Macro Scalar_let_Mat2x4(res, s, op, m)
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[0]\w =(s) op m\column[0]\w
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[1]\w =(s) op m\column[1]\w
EndMacro
Declare Mat2x4_add(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x4)
Declare Mat2x4_sub(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x4)
Declare Mat2x4_mul_Mat2x2(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x2)
Declare Mat2x4_mul_Mat3x2(*res.Mat3x4, *m1.Mat2x4, *m2.Mat3x2)
Declare Mat2x4_mul_Mat4x2(*res.Mat4x4, *m1.Mat2x4, *m2.Mat4x2)
Declare Mat2x4_mul_Vec2(*vecres.Vec4, *m.Mat2x4, *v.Vec2)
Declare Vec4_mul_Mat2x4(*vecres.Vec2, *v.Vec4, *m.Mat2x4)
;- Mat3x2
Macro Mat3x2_set (res, x0 = 1, y0 = 0, x1 = 0, y1 = 1, x2 = 0, y2 = 0)
res\column[0]\x = x0
res\column[0]\y = y0
res\column[1]\x = x1
res\column[1]\y = y1
res\column[2]\x = x2
res\column[2]\y = y2
EndMacro
Macro Mat3x2_set_Vec(res, v0, v1, v2)
res\column[0]\x = v0\x
res\column[0]\y = v0\y
res\column[1]\x = v1\x
res\column[1]\y = v1\y
res\column[2]\x = v2\x
res\column[2]\y = v2\y
EndMacro
Macro Mat3x2_set_Mat2x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
EndMacro
Macro Mat3x2_set_Mat2x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
EndMacro
Macro Mat3x2_set_Mat2x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
EndMacro
Macro Mat3x2_set_Mat3x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
EndMacro
Macro Mat3x2_set_Mat3x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
EndMacro
Macro Mat3x2_set_Mat3x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
EndMacro
Macro Mat3x2_set_Mat4x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
EndMacro
Macro Mat3x2_set_Mat4x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
EndMacro
Macro Mat3x2_set_Mat4x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
EndMacro
Macro Mat3x2_set_Scalar(res, s)
res\column[0]\x = s
res\column[0]\y = 0.0
res\column[1]\x = 0.0
res\column[1]\y = s
res\column[2]\x = 0.0
res\column[2]\y = 0.0
EndMacro
Macro Mat3x2_let_Scalar(res, m, op, s)
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
EndMacro
Macro Scalar_let_Mat3x2(res, s, op, m)
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
EndMacro
Declare Mat3x2_add(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x2)
Declare Mat3x2_sub(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x2)
Declare Mat3x2_mul_Mat2x3(*res.Mat2x2, *m1.Mat3x2, *m2.Mat2x3)
Declare Mat3x2_mul_Mat3x3(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x3)
Declare Mat3x2_mul_Mat4x3(*res.Mat4x2, *m1.Mat3x2, *m2.Mat4x3)
Declare Mat3x2_mul_Vec3(*vecres.Vec2, *m.Mat3x2, *v.Vec3)
Declare Vec2_mul_Mat3x2(*vecres.Vec3, *v.Vec2, *m.Mat3x2)
;- Mat3x3
Macro Mat3x3_set (res, x0 = 1, y0 = 0, z0 = 0, x1 = 0, y1 = 1, z1 = 0, x2 = 0, y2 = 0, z2 = 1)
res\column[0]\x = x0
res\column[0]\y = y0
res\column[0]\z = z0
res\column[1]\x = x1
res\column[1]\y = y1
res\column[1]\z = z1
res\column[2]\x = x2
res\column[2]\y = y2
res\column[2]\z = z2
EndMacro
Macro Mat3x3_set_Vec(res, v0, v1, v2)
res\column[0]\x = v0\x
res\column[0]\y = v0\y
res\column[0]\z = v0\z
res\column[1]\x = v1\x
res\column[1]\y = v1\y
res\column[1]\z = v1\z
res\column[2]\x = v2\x
res\column[2]\y = v2\y
res\column[2]\z = v2\z
EndMacro
Macro Mat3x3_set_Mat2x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
EndMacro
Macro Mat3x3_set_Mat2x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
EndMacro
Macro Mat3x3_set_Mat2x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
EndMacro
Macro Mat3x3_set_Mat3x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
EndMacro
Macro Mat3x3_set_Mat3x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
EndMacro
Macro Mat3x3_set_Mat3x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
EndMacro
Macro Mat3x3_set_Mat4x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
EndMacro
Macro Mat3x3_set_Mat4x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
EndMacro
Macro Mat3x3_set_Mat4x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
EndMacro
Macro Mat3x3_set_Scalar(res, s)
res\column[0]\x = s
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[1]\x = 0.0
res\column[1]\y = s
res\column[1]\z = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = s
EndMacro
Macro Mat3x3_let_Scalar(res, m, op, s)
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[2]\z = m\column[2]\z op(s)
EndMacro
Macro Scalar_let_Mat3x3(res, s, op, m)
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[2]\z =(s) op m\column[2]\z
EndMacro
Declare Mat3x3_add(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
Declare Mat3x3_sub(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
Declare Mat3x3_mul_Mat2x3(*res.Mat2x3, *m1.Mat3x3, *m2.Mat2x3)
Declare Mat3x3_mul_Mat3x3(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
Declare Mat3x3_mul_Mat4x3(*res.Mat4x3, *m1.Mat3x3, *m2.Mat4x3)
Declare Mat3x3_div(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
Declare Mat3x3_div_Vec3(*res.vec3, *m.Mat3x3, *v.vec3)
Declare Vec3_div_Mat3x3(*res.vec3, *v.vec3, *m.Mat3x3)
Declare Mat3x3_mul_Vec3(*vecres.Vec3, *m.Mat3x3, *v.Vec3)
Declare Vec3_mul_Mat3x3(*vecres.Vec3, *v.Vec3, *m.Mat3x3)
;- Mat3x4
Macro Mat3x4_set (res, x0 = 1, y0 = 0, z0 = 0, w0 = 0, x1 = 0, y1 = 1, z1 = 0, w1 = 0, x2 = 0, y2 = 0, z2 = 1, w2 = 0)
res\column[0]\x = x0
res\column[0]\y = y0
res\column[0]\z = z0
res\column[0]\w = w0
res\column[1]\x = x1
res\column[1]\y = y1
res\column[1]\z = z1
res\column[1]\w = w1
res\column[2]\x = x2
res\column[2]\y = y2
res\column[2]\z = z2
res\column[2]\w = w2
EndMacro
Macro Mat3x4_set_Vec(res, v0, v1, v2)
res\column[0]\x = v0\x
res\column[0]\y = v0\y
res\column[0]\z = v0\z
res\column[0]\w = v0\w
res\column[1]\x = v1\x
res\column[1]\y = v1\y
res\column[1]\z = v1\z
res\column[1]\w = v1\w
res\column[2]\x = v2\x
res\column[2]\y = v2\y
res\column[2]\z = v2\z
res\column[2]\w = v2\w
EndMacro
Macro Mat3x4_set_Mat2x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
EndMacro
Macro Mat3x4_set_Mat2x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
EndMacro
Macro Mat3x4_set_Mat2x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
EndMacro
Macro Mat3x4_set_Mat3x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[2]\w = 0.0
EndMacro
Macro Mat3x4_set_Mat3x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = 0.0
EndMacro
Macro Mat3x4_set_Mat3x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = m\v[2]\w
EndMacro
Macro Mat3x4_set_Mat4x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[2]\w = 0.0
EndMacro
Macro Mat3x4_set_Mat4x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = 0.0
EndMacro
Macro Mat3x4_set_Mat4x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = m\v[2]\w
EndMacro
Macro Mat3x4_set_Scalar(res, s)
res\column[0]\x = s
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = 0.0
res\column[1]\y = s
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = s
res\column[2]\w = 0.0
EndMacro
Macro Mat3x4_let_Scalar(res, m, op, s)
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[0]\w = m\column[0]\w op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[1]\w = m\column[1]\w op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[2]\z = m\column[2]\z op(s)
res\column[2]\w = m\column[2]\w op(s)
EndMacro
Macro Scalar_let_Mat3x4(res, s, op, m)
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[0]\w =(s) op m\column[0]\w
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[1]\w =(s) op m\column[1]\w
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[2]\z =(s) op m\column[2]\z
res\column[2]\w =(s) op m\column[2]\w
EndMacro
Declare Mat3x4_add(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x4)
Declare Mat3x4_sub(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x4)
Declare Mat3x4_mul_Mat2x3(*res.Mat2x4, *m1.Mat3x4, *m2.Mat2x3)
Declare Mat3x4_mul_Mat3x3(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x3)
Declare Mat3x4_mul_Mat4x3(*res.Mat4x4, *m1.Mat3x4, *m2.Mat4x3)
Declare Mat3x4_mul_Vec3(*vecres.Vec4, *m.Mat3x4, *v.Vec3)
Declare Vec4_mul_Mat3x4(*vecres.Vec3, *v.Vec4, *m.Mat3x4)
;- Mat4x2
Macro Mat4x2_set (res, x0 = 1, y0 = 0, x1 = 0, y1 = 1, x2 = 0, y2 = 0, x3 = 0, y3 = 0)
res\column[0]\x = x0
res\column[0]\y = y0
res\column[1]\x = x1
res\column[1]\y = y1
res\column[2]\x = x2
res\column[2]\y = y2
res\column[3]\x = x3
res\column[3]\y = y3
EndMacro
Macro Mat4x2_set_Vec(res, v0, v1, v2, v3)
res\column[0]\x = v0\x
res\column[0]\y = v0\y
res\column[1]\x = v1\x
res\column[1]\y = v1\y
res\column[2]\x = v2\x
res\column[2]\y = v2\y
res\column[3]\x = v3\x
res\column[3]\y = v3\y
EndMacro
Macro Mat4x2_set_Mat2x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
EndMacro
Macro Mat4x2_set_Mat2x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
EndMacro
Macro Mat4x2_set_Mat2x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
EndMacro
Macro Mat4x2_set_Mat3x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = 0.0
res\column[3]\y = 0.0
EndMacro
Macro Mat4x2_set_Mat3x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = 0.0
res\column[3]\y = 0.0
EndMacro
Macro Mat4x2_set_Mat3x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = 0.0
res\column[3]\y = 0.0
EndMacro
Macro Mat4x2_set_Mat4x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
EndMacro
Macro Mat4x2_set_Mat4x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
EndMacro
Macro Mat4x2_set_Mat4x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
EndMacro
Macro Mat4x2_set_Scalar(res, s)
res\column[0]\x = s
res\column[0]\y = 0.0
res\column[1]\x = 0.0
res\column[1]\y = s
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
EndMacro
Macro Mat4x2_let_Scalar(res, m, op, s)
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[3]\x = m\column[3]\x op(s)
res\column[3]\y = m\column[3]\y op(s)
EndMacro
Macro Scalar_let_Mat4x2(res, s, op, m)
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[3]\x =(s) op m\column[3]\x
res\column[3]\y =(s) op m\column[3]\y
EndMacro
Declare Mat4x2_add(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x2)
Declare Mat4x2_sub(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x2)
Declare Mat4x2_mul_Mat2x4(*res.Mat2x2, *m1.Mat4x2, *m2.Mat2x4)
Declare Mat4x2_mul_Mat3x4(*res.Mat3x2, *m1.Mat4x2, *m2.Mat3x4)
Declare Mat4x2_mul_Mat4x4(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x4)
Declare Mat4x2_mul_Vec4(*vecres.Vec2, *m.Mat4x2, *v.Vec4)
Declare Vec2_mul_Mat4x2(*vecres.Vec4, *v.Vec2, *m.Mat4x2)
;- Mat4x3
Macro Mat4x3_set (res, x0 = 1, y0 = 0, z0 = 0, x1 = 0, y1 = 1, z1 = 0, x2 = 0, y2 = 0, z2 = 1, x3 = 0, y3 = 0, z3 = 0)
res\column[0]\x = x0
res\column[0]\y = y0
res\column[0]\z = z0
res\column[1]\x = x1
res\column[1]\y = y1
res\column[1]\z = z1
res\column[2]\x = x2
res\column[2]\y = y2
res\column[2]\z = z2
res\column[3]\x = x3
res\column[3]\y = y3
res\column[3]\z = z3
EndMacro
Macro Mat4x3_set_Vec(res, v0, v1, v2, v3)
res\column[0]\x = v0\x
res\column[0]\y = v0\y
res\column[0]\z = v0\z
res\column[1]\x = v1\x
res\column[1]\y = v1\y
res\column[1]\z = v1\z
res\column[2]\x = v2\x
res\column[2]\y = v2\y
res\column[2]\z = v2\z
res\column[3]\x = v3\x
res\column[3]\y = v3\y
res\column[3]\z = v3\z
EndMacro
Macro Mat4x3_set_Mat2x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
EndMacro
Macro Mat4x3_set_Mat2x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
EndMacro
Macro Mat4x3_set_Mat2x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
EndMacro
Macro Mat4x3_set_Mat3x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
EndMacro
Macro Mat4x3_set_Mat3x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
EndMacro
Macro Mat4x3_set_Mat3x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
EndMacro
Macro Mat4x3_set_Mat4x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = 0.0
EndMacro
Macro Mat4x3_set_Mat4x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = m\v[3]\z
EndMacro
Macro Mat4x3_set_Mat4x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = m\v[3]\z
EndMacro
Macro Mat4x3_set_Scalar(res, s)
res\column[0]\x = s
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[1]\x = 0.0
res\column[1]\y = s
res\column[1]\z = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = s
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
EndMacro
Macro Mat4x3_let_Scalar(res, m, op, s)
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[2]\z = m\column[2]\z op(s)
res\column[3]\x = m\column[3]\x op(s)
res\column[3]\y = m\column[3]\y op(s)
res\column[3]\z = m\column[3]\z op(s)
EndMacro
Macro Scalar_let_Mat4x3(res, s, op, m)
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[2]\z =(s) op m\column[2]\z
res\column[3]\x =(s) op m\column[3]\x
res\column[3]\y =(s) op m\column[3]\y
res\column[3]\z =(s) op m\column[3]\z
EndMacro
Declare Mat4x3_add(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x3)
Declare Mat4x3_sub(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x3)
Declare Mat4x3_mul_Mat2x4(*res.Mat2x3, *m1.Mat4x3, *m2.Mat2x4)
Declare Mat4x3_mul_Mat3x4(*res.Mat3x3, *m1.Mat4x3, *m2.Mat3x4)
Declare Mat4x3_mul_Mat4x4(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x4)
Declare Mat4x3_mul_Vec4(*vecres.Vec3, *m.Mat4x3, *v.Vec4)
Declare Vec3_mul_Mat4x3(*vecres.Vec4, *v.Vec3, *m.Mat4x3)
;- Mat4x4
Macro Mat4x4_set (res, x0 = 1, y0 = 0, z0 = 0, w0 = 0, x1 = 0, y1 = 1, z1 = 0, w1 = 0, x2 = 0, y2 = 0, z2 = 1, w2 = 0, x3 = 0, y3 = 0, z3 = 0, w3 = 1)
res\column[0]\x = x0
res\column[0]\y = y0
res\column[0]\z = z0
res\column[0]\w = w0
res\column[1]\x = x1
res\column[1]\y = y1
res\column[1]\z = z1
res\column[1]\w = w1
res\column[2]\x = x2
res\column[2]\y = y2
res\column[2]\z = z2
res\column[2]\w = w2
res\column[3]\x = x3
res\column[3]\y = y3
res\column[3]\z = z3
res\column[3]\w = w3
EndMacro
Macro Mat4x4_set_Vec(res, v0, v1, v2, v3)
res\column[0]\x = v0\x
res\column[0]\y = v0\y
res\column[0]\z = v0\z
res\column[0]\w = v0\w
res\column[1]\x = v1\x
res\column[1]\y = v1\y
res\column[1]\z = v1\z
res\column[1]\w = v1\w
res\column[2]\x = v2\x
res\column[2]\y = v2\y
res\column[2]\z = v2\z
res\column[2]\w = v2\w
res\column[3]\x = v3\x
res\column[3]\y = v3\y
res\column[3]\z = v3\z
res\column[3]\w = v3\w
EndMacro
Macro Mat4x4_set_Mat2x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
EndMacro
Macro Mat4x4_set_Mat2x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
EndMacro
Macro Mat4x4_set_Mat2x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
EndMacro
Macro Mat4x4_set_Mat3x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
EndMacro
Macro Mat4x4_set_Mat3x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
EndMacro
Macro Mat4x4_set_Mat3x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = m\v[2]\w
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
EndMacro
Macro Mat4x4_set_Mat4x2(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = 0.0
res\column[3]\w = 1.0
EndMacro
Macro Mat4x4_set_Mat4x3(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = 0.0
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = m\v[3]\z
res\column[3]\w = 1.0
EndMacro
Macro Mat4x4_set_Mat4x4(res, m)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = m\v[2]\w
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = m\v[3]\z
res\column[3]\w = m\v[3]\w
EndMacro
Macro Mat4x4_set_Scalar(res, s)
res\column[0]\x = s
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = 0.0
res\column[1]\y = s
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = s
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = s
EndMacro
Macro Mat4x4_let_Scalar(res, m, op, s)
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[0]\w = m\column[0]\w op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[1]\w = m\column[1]\w op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[2]\z = m\column[2]\z op(s)
res\column[2]\w = m\column[2]\w op(s)
res\column[3]\x = m\column[3]\x op(s)
res\column[3]\y = m\column[3]\y op(s)
res\column[3]\z = m\column[3]\z op(s)
res\column[3]\w = m\column[3]\w op(s)
EndMacro
Macro Scalar_let_Mat4x4(res, s, op, m)
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[0]\w =(s) op m\column[0]\w
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[1]\w =(s) op m\column[1]\w
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[2]\z =(s) op m\column[2]\z
res\column[2]\w =(s) op m\column[2]\w
res\column[3]\x =(s) op m\column[3]\x
res\column[3]\y =(s) op m\column[3]\y
res\column[3]\z =(s) op m\column[3]\z
res\column[3]\w =(s) op m\column[3]\w
EndMacro
Declare Mat4x4_add(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
Declare Mat4x4_sub(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
Declare Mat4x4_mul_Mat2x4(*res.Mat2x4, *m1.Mat4x4, *m2.Mat2x4)
Declare Mat4x4_mul_Mat3x4(*res.Mat3x4, *m1.Mat4x4, *m2.Mat3x4)
Declare Mat4x4_mul_Mat4x4(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
Declare Mat4x4_div(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
Declare Mat4x4_div_Vec4(*res.vec4, *m.Mat4x4, *v.vec4)
Declare Vec4_div_Mat4x4(*res.vec4, *v.vec4, *m.Mat4x4)
Declare Mat4x4_mul_Vec4(*vecres.Vec4, *m.Mat4x4, *v.Vec4)
Declare Vec4_mul_Mat4x4(*vecres.Vec4, *v.Vec4, *m.Mat4x4)
;}
;-----------------------
;- func_matrix.pbi
;{

Declare Mat2x2_inverse(*res.Mat2x2, *m.Mat2x2)
Declare Mat3x3_inverse(*res.Mat3x3, *m.Mat3x3)
Declare Mat4x4_inverse(*res.mat4x4, *m.Mat4x4)
Declare mat2x2_transpose(*res.mat2x2, *m.mat2x2)
Declare mat2x3_transpose(*res.mat2x3, *m.mat3x2)
Declare mat2x4_transpose(*res.mat2x4, *m.mat4x2)
Declare mat3x2_transpose(*res.mat3x2, *m.mat2x3)
Declare mat3x3_transpose(*res.mat3x3, *m.mat3x3)
Declare mat3x4_transpose(*res.mat3x4, *m.mat4x3)
Declare mat4x2_transpose(*res.mat4x2, *m.mat2x4)
Declare mat4x3_transpose(*res.mat4x3, *m.mat3x4)
Declare mat4x4_transpose(*res.mat4x4, *m.mat4x4)
Declare.f mat2x2_determinant(*m.mat2x2)
Declare.f mat3x3_determinant(*m.mat3x3)
Declare.f mat4x4_determinant(*m.mat4x4)
Macro matrixCompMult(res, x,y)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_matrixCompMult(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), x,y)
EndMacro
Macro outerProduct(res, v1, v2)
_math::compute_outerProduct(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), v1, v2)
EndMacro
;}
;-----------------------
;- dispatcher.pbi
;{

Macro add(res, m1, m2)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(m1\__type0__)&1)<<0) +((TypeOf(m1\__type1__)&1)<<1) +((TypeOf(m1\__type2__)&1)<<2) +((TypeOf(m1\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(m2\__type0__)&1)<<0) +((TypeOf(m2\__type1__)&1)<<1) +((TypeOf(m2\__type2__)&1)<<2) + ((TypeOf(m2\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
res\w = m1\w + m2\w
res\x = m1\x + m2\x
res\y = m1\y + m2\y
res\z = m1\z + m2\z
    CompilerCase math::#type_vec2
res\x = m1\x + m2\x
res\y = m1\y + m2\y
    CompilerCase math::#type_vec3
res\x = m1\x + m2\x
res\y = m1\y + m2\y
res\z = m1\z + m2\z
    CompilerCase math::#type_vec4
res\x = m1\x + m2\x
res\y = m1\y + m2\y
res\z = m1\z + m2\z
res\w = m1\w + m2\w
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_add(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::Mat2x3_add(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::Mat2x4_add(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::Mat3x2_add(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_add(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::Mat3x4_add(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::Mat4x2_add(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::Mat4x3_add(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_add(res, m1, m2)
    CompilerDefault
      CompilerError "[add] unsupported type"
  CompilerEndSelect
EndMacro
Macro mul(res, m1, m2)
CompilerSelect(((((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3))) +((((TypeOf(m1\__type0__)&1)<<0) +((TypeOf(m1\__type1__)&1)<<1) +((TypeOf(m1\__type2__)&1)<<2) +((TypeOf(m1\__type3__)&1)<<3))) <<8 +((((TypeOf(m2\__type0__)&1)<<0) +((TypeOf(m2\__type1__)&1)<<1) +((TypeOf(m2\__type2__)&1)<<2) + ((TypeOf(m2\__type3__)&1)<<3)))<<16)
CompilerCase ((math::#type_quat) +(math::#type_quat) <<8 +(math::#type_quat) <<16);quat
      math::quat_mul(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_quat) <<8 +(math::#type_vec3) <<16)
      math::quat_mul_vec3(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8 +(math::#type_quat) <<16)
      math::vec3_mul_quat(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_quat) <<8 +(math::#type_vec3) <<16)
      math::quat_mul_vec4(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8 +(math::#type_quat) <<16)
      math::vec4_mul_quat(res, m1, m2)
CompilerCase ((math::#type_vec2) +(math::#type_vec2) <<8 +(math::#type_vec2) <<16); vec vec
res\x = m1\x * m2\x
res\y = m1\y * m2\y
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8 +(math::#type_vec3) <<16)
res\x = m1\x * m2\x
res\y = m1\y * m2\y
res\z = m1\z * m2\z
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8 +(math::#type_vec4) <<16)
res\x = m1\x * m2\x
res\y = m1\y * m2\y
res\z = m1\z * m2\z
res\w = m1\w * m2\w
CompilerCase ((math::#type_Vec2) +(math::#type_Mat2x2) <<8 +(math::#type_Vec2) <<16); mat vec
      math::Mat2x2_mul_Vec2(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Mat2x3) <<8 +(math::#type_Vec2) <<16)
      math::Mat2x3_mul_Vec2(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Mat2x4) <<8 +(math::#type_Vec2) <<16)
      math::Mat2x4_mul_Vec2(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Mat3x2) <<8 +(math::#type_Vec3) <<16)
      math::Mat3x2_mul_Vec3(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Mat3x3) <<8 +(math::#type_Vec3) <<16)
      math::Mat3x3_mul_Vec3(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Mat3x4) <<8 +(math::#type_Vec3) <<16)
      math::Mat3x4_mul_Vec3(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Mat4x2) <<8 +(math::#type_Vec4) <<16)
      math::Mat4x2_mul_Vec4(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Mat4x3) <<8 +(math::#type_Vec4) <<16)
      math::Mat4x3_mul_Vec4(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Mat4x4) <<8 +(math::#type_Vec4) <<16)
      math::Mat4x4_mul_Vec4(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Vec2) <<8 +(math::#type_Mat2x2) <<16); vec mat
      math::Vec2_mul_Mat2x2(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Vec3) <<8 +(math::#type_Mat2x3) <<16)
      math::Vec3_mul_Mat2x3(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Vec4) <<8 +(math::#type_Mat2x4) <<16)
      math::Vec4_mul_Mat2x4(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Vec2) <<8 +(math::#type_Mat3x2) <<16)
      math::Vec2_mul_Mat3x2(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Vec3) <<8 +(math::#type_Mat3x3) <<16)
      math::Vec3_mul_Mat3x3(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Vec4) <<8 +(math::#type_Mat3x4) <<16)
      math::Vec4_mul_Mat3x4(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Vec2) <<8 +(math::#type_Mat4x2) <<16)
      math::Vec2_mul_Mat4x2(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Vec3) <<8 +(math::#type_Mat4x3) <<16)
      math::Vec3_mul_Mat4x3(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Vec4) <<8 +(math::#type_Mat4x4) <<16)
      math::Vec4_mul_Mat4x4(res, m1, m2)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x2) <<8 +(math::#type_Mat2x2) <<16);mat mat
      math::Mat2x2_mul_Mat2x2(res, m1, m2)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat2x2) <<8 +(math::#type_Mat3x2) <<16)
      math::Mat2x2_mul_Mat3x2(res, m1, m2)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat2x2) <<8 +(math::#type_Mat4x2) <<16)
      math::Mat2x2_mul_Mat4x2(res, m1, m2)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat2x3) <<8 +(math::#type_Mat2x2) <<16)
      math::Mat2x3_mul_Mat2x2(res, m1, m2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat2x3) <<8 +(math::#type_Mat3x2) <<16)
      math::Mat2x3_mul_Mat3x2(res, m1, m2)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat2x3) <<8 +(math::#type_Mat4x2) <<16)
      math::Mat2x3_mul_Mat4x2(res, m1, m2)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat2x4) <<8 +(math::#type_Mat2x2) <<16)
      math::Mat2x4_mul_Mat2x2(res, m1, m2)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat2x4) <<8 +(math::#type_Mat3x2) <<16)
      math::Mat2x4_mul_Mat3x2(res, m1, m2)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat2x4) <<8 +(math::#type_Mat4x2) <<16)
      math::Mat2x4_mul_Mat4x2(res, m1, m2)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat3x2) <<8 +(math::#type_Mat2x3) <<16)
      math::Mat3x2_mul_Mat2x3(res, m1, m2)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat3x2) <<8 +(math::#type_Mat3x3) <<16)
      math::Mat3x2_mul_Mat3x3(res, m1, m2)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat3x2) <<8 +(math::#type_Mat4x3) <<16)
      math::Mat3x2_mul_Mat4x3(res, m1, m2)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat3x3) <<8 +(math::#type_Mat2x3) <<16)
      math::Mat3x3_mul_Mat2x3(res, m1, m2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x3) <<8 +(math::#type_Mat3x3) <<16)
      math::Mat3x3_mul_Mat3x3(res, m1, m2)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat3x3) <<8 +(math::#type_Mat4x3) <<16)
      math::Mat3x3_mul_Mat4x3(res, m1, m2)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat3x4) <<8 +(math::#type_Mat2x3) <<16)
      math::Mat3x4_mul_Mat2x3(res, m1, m2)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat3x4) <<8 +(math::#type_Mat3x3) <<16)
      math::Mat3x4_mul_Mat3x3(res, m1, m2)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat3x4) <<8 +(math::#type_Mat4x3) <<16)
      math::Mat3x4_mul_Mat4x3(res, m1, m2)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat4x2) <<8 +(math::#type_Mat2x4) <<16)
      math::Mat4x2_mul_Mat2x4(res, m1, m2)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat4x2) <<8 +(math::#type_Mat3x4) <<16)
      math::Mat4x2_mul_Mat3x4(res, m1, m2)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat4x2) <<8 +(math::#type_Mat4x4) <<16)
      math::Mat4x2_mul_Mat4x4(res, m1, m2)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat4x3) <<8 +(math::#type_Mat2x4) <<16)
      math::Mat4x3_mul_Mat2x4(res, m1, m2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat4x3) <<8 +(math::#type_Mat3x4) <<16)
      math::Mat4x3_mul_Mat3x4(res, m1, m2)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat4x3) <<8 +(math::#type_Mat4x4) <<16)
      math::Mat4x3_mul_Mat4x4(res, m1, m2)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat4x4) <<8 +(math::#type_Mat2x4) <<16)
      math::Mat4x4_mul_Mat2x4(res, m1, m2)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat4x4) <<8 +(math::#type_Mat3x4) <<16)
      math::Mat4x4_mul_Mat3x4(res, m1, m2)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x4) <<8 +(math::#type_Mat4x4) <<16)
      math::Mat4x4_mul_Mat4x4(res, m1, m2)
    CompilerDefault
      CompilerError "[mul] unsupported type"
  CompilerEndSelect
EndMacro
Macro sub(res, m1, m2)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(m1\__type0__)&1)<<0) +((TypeOf(m1\__type1__)&1)<<1) +((TypeOf(m1\__type2__)&1)<<2) +((TypeOf(m1\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(m2\__type0__)&1)<<0) +((TypeOf(m2\__type1__)&1)<<1) +((TypeOf(m2\__type2__)&1)<<2) + ((TypeOf(m2\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
res\w = m1\w - m2\w
res\x = m1\x - m2\x
res\y = m1\y - m2\y
res\z = m1\z - m2\z
    CompilerCase math::#type_vec2
res\x = m1\x - m2\x
res\y = m1\y - m2\y
    CompilerCase math::#type_vec3
res\x = m1\x - m2\x
res\y = m1\y - m2\y
res\z = m1\z - m2\z
    CompilerCase math::#type_vec4
res\x = m1\x - m2\x
res\y = m1\y - m2\y
res\z = m1\z - m2\z
res\w = m1\w - m2\w
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_sub(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::Mat2x3_sub(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::Mat2x4_sub(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::Mat3x2_sub(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_sub(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::Mat3x4_sub(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::Mat4x2_sub(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::Mat4x3_sub(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_sub(res, m1, m2)
    CompilerDefault
      CompilerError "[sub] unsupported type"
  CompilerEndSelect
EndMacro
Macro set_float(res, f0=0.0,f1=,f2=,f3=,f4=,f5=,f6=,f7=,f8=,f9=,f10=,f11=,f12=,f13=,f14=,f15=)
CompilerIf (_math::dq#f1#_math::dq = "");set Scalar
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
      CompilerCase math::#type_quat
res\w =(f0)
res\x =(f0)
res\y =(f0)
res\z =(f0)
      CompilerCase math::#type_vec2
res\x =(f0)
res\y =(f0)
      CompilerCase math::#type_vec3
res\x =(f0)
res\y =(f0)
res\z =(f0)
      CompilerCase math::#type_vec4
res\x =(f0)
res\y =(f0)
res\z =(f0)
res\w =(f0)
      CompilerCase math::#type_Mat2x2
res\column[0]\x = f0
res\column[0]\y = 0.0
res\column[1]\x = 0.0
res\column[1]\y = f0
      CompilerCase math::#type_Mat2x3
res\column[0]\x = f0
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[1]\x = 0.0
res\column[1]\y = f0
res\column[1]\z = 0.0
      CompilerCase math::#type_Mat2x4
res\column[0]\x = f0
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = 0.0
res\column[1]\y = f0
res\column[1]\z = 0.0
res\column[1]\w = 0.0
      CompilerCase math::#type_Mat3x2
res\column[0]\x = f0
res\column[0]\y = 0.0
res\column[1]\x = 0.0
res\column[1]\y = f0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
      CompilerCase math::#type_Mat3x3
res\column[0]\x = f0
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[1]\x = 0.0
res\column[1]\y = f0
res\column[1]\z = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = f0
      CompilerCase math::#type_Mat3x4
res\column[0]\x = f0
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = 0.0
res\column[1]\y = f0
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = f0
res\column[2]\w = 0.0
      CompilerCase math::#type_Mat4x2
res\column[0]\x = f0
res\column[0]\y = 0.0
res\column[1]\x = 0.0
res\column[1]\y = f0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
      CompilerCase math::#type_Mat4x3
res\column[0]\x = f0
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[1]\x = 0.0
res\column[1]\y = f0
res\column[1]\z = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = f0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
      CompilerCase math::#type_Mat4x4
res\column[0]\x = f0
res\column[0]\y = 0.0
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = 0.0
res\column[1]\y = f0
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = f0
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = f0
      CompilerDefault
        CompilerError "[set_float] unsupported type"
    CompilerEndSelect
  CompilerElse
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
      CompilerCase math::#type_quat
res\x = f1
res\y = f2
res\z = f3
res\w = f0
      CompilerCase math::#type_vec2
res\x = f0
res\y = f1
      CompilerCase math::#type_vec3
res\x = f0
res\y = f1
res\z = f2
      CompilerCase math::#type_vec4
res\x = f0
res\y = f1
res\z = f2
res\w = f3
      CompilerCase math::#type_Mat2x2
res\column[0]\x = f0
res\column[0]\y = f1
res\column[1]\x = f2
res\column[1]\y = f3
      CompilerCase math::#type_Mat2x3
res\column[0]\x = f0
res\column[0]\y = f1
res\column[0]\z = f2
res\column[1]\x = f3
res\column[1]\y = f4
res\column[1]\z = f5
      CompilerCase math::#type_Mat2x4
res\column[0]\x = f0
res\column[0]\y = f1
res\column[0]\z = f2
res\column[0]\w = f3
res\column[1]\x = f4
res\column[1]\y = f5
res\column[1]\z = f6
res\column[1]\w = f7
      CompilerCase math::#type_Mat3x2
res\column[0]\x = f0
res\column[0]\y = f1
res\column[1]\x = f2
res\column[1]\y = f3
res\column[2]\x = f4
res\column[2]\y = f5
      CompilerCase math::#type_Mat3x3
res\column[0]\x = f0
res\column[0]\y = f1
res\column[0]\z = f2
res\column[1]\x = f3
res\column[1]\y = f4
res\column[1]\z = f5
res\column[2]\x = f6
res\column[2]\y = f7
res\column[2]\z = f8
      CompilerCase math::#type_Mat3x4
res\column[0]\x = f0
res\column[0]\y = f1
res\column[0]\z = f2
res\column[0]\w = f3
res\column[1]\x = f4
res\column[1]\y = f5
res\column[1]\z = f6
res\column[1]\w = f7
res\column[2]\x = f8
res\column[2]\y = f9
res\column[2]\z = f10
res\column[2]\w = f11
      CompilerCase math::#type_Mat4x2
res\column[0]\x = f0
res\column[0]\y = f1
res\column[1]\x = f2
res\column[1]\y = f3
res\column[2]\x = f4
res\column[2]\y = f5
res\column[3]\x = f6
res\column[3]\y = f7
      CompilerCase math::#type_Mat4x3
res\column[0]\x = f0
res\column[0]\y = f1
res\column[0]\z = f2
res\column[1]\x = f3
res\column[1]\y = f4
res\column[1]\z = f5
res\column[2]\x = f6
res\column[2]\y = f7
res\column[2]\z = f8
res\column[3]\x = f9
res\column[3]\y = f10
res\column[3]\z = f11
      CompilerCase math::#type_Mat4x4
res\column[0]\x = f0
res\column[0]\y = f1
res\column[0]\z = f2
res\column[0]\w = f3
res\column[1]\x = f4
res\column[1]\y = f5
res\column[1]\z = f6
res\column[1]\w = f7
res\column[2]\x = f8
res\column[2]\y = f9
res\column[2]\z = f10
res\column[2]\w = f11
res\column[3]\x = f12
res\column[3]\y = f13
res\column[3]\z = f14
res\column[3]\w = f15
      CompilerDefault
        CompilerError "[set_float] unsupported type"
    CompilerEndSelect
  CompilerEndIf
EndMacro
Macro set(res, m, v1=, v2=, v3=)
CompilerSelect(((((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3))) +((((TypeOf(m\__type0__)&1)<<0) +((TypeOf(m\__type1__)&1)<<1) +((TypeOf(m\__type2__)&1)<<2) + ((TypeOf(m\__type3__)&1)<<3)))<<8)
CompilerCase ((math::#type_quat) +(math::#type_quat) <<8);quat
res\w = m\w
res\x = m\x
res\y = m\y
res\z = m\z
CompilerCase ((math::#type_quat) +(math::#type_vec3) <<8)
      CompilerIf _math::dq#v1#_math::dq = ""
        math::quat_set_eulerAngle(res, m)
      CompilerElse
        math::quat_set_vec3_vec3(res, m, v1)
      CompilerEndIf      
CompilerCase ((math::#type_quat) +(math::#type_mat3x3) <<8)
      math::quat_set_mat3x3(res, m)
CompilerCase ((math::#type_quat) +(math::#type_mat4x4) <<8)
      math::quat_set_mat4x4(res, m)
CompilerCase ((math::#type_mat3x3) +(math::#type_quat) <<8)
      math::mat3x3_set_quat(res, m)
CompilerCase ((math::#type_mat4x4) +(math::#type_quat) <<8)
      math::mat4x4_set_quat(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_vec2) <<8);mat vec
      math::Mat2x2_set_Vec2(res, m, v1)
CompilerCase ((math::#type_Mat2x3) +(math::#type_vec3) <<8)
      math::Mat2x3_set_Vec3(res, m, v1)
CompilerCase ((math::#type_Mat2x4) +(math::#type_vec4) <<8)
      math::Mat2x4_set_Vec4(res, m, v1)
CompilerCase ((math::#type_Mat3x2) +(math::#type_vec2) <<8)
      math::Mat3x2_set_Vec2(res, m, v1, v2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_vec3) <<8)
      math::Mat3x3_set_Vec3(res, m, v1, v2)
CompilerCase ((math::#type_Mat3x4) +(math::#type_vec4) <<8)
      math::Mat3x4_set_Vec4(res, m, v1, v2)
CompilerCase ((math::#type_Mat4x2) +(math::#type_vec2) <<8)
      math::Mat4x2_set_Vec2(res, m, v1, v2, v3)
CompilerCase ((math::#type_Mat4x3) +(math::#type_vec3) <<8)
      math::Mat4x3_set_Vec3(res, m, v1, v2, v3)
CompilerCase ((math::#type_Mat4x4) +(math::#type_vec4) <<8)
      math::Mat4x4_set_Vec4(res, m, v1, v2, v3)
CompilerCase ((math::#type_vec2) +(math::#type_vec2) <<8);vec vec
res\x = m\x
res\y = m\y
CompilerCase ((math::#type_vec2) +(math::#type_vec3) <<8)
res\x = m\x
res\y = m\y
CompilerCase ((math::#type_vec2) +(math::#type_vec4) <<8)
res\x = m\x
res\y = m\y
CompilerCase ((math::#type_vec3) +(math::#type_vec2) <<8);vec vec
res\x = m\x
res\y = m\y
res\z = 0
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8)
res\x = m\x
res\y = m\y
res\z = m\z
CompilerCase ((math::#type_vec3) +(math::#type_vec4) <<8)
res\x = m\x
res\y = m\y
res\z = m\z
CompilerCase ((math::#type_vec4) +(math::#type_vec3) <<8);vec vec
res\x = m\x
res\y = m\y
res\z = m\z
res\w = 0
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8)
res\x = m\x
res\y = m\y
res\z = m\z
res\w = m\w
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x2) <<8);mat mat
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat3x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat3x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat3x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat4x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat4x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat4x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat2x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat2x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat2x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat3x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat3x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat3x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat4x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat4x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat4x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat2x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat2x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat2x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat3x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat3x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat3x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat4x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat4x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat4x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat2x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat2x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat2x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat3x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat3x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat3x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat4x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat4x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat4x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat2x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat2x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat2x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat4x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat4x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat4x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat2x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat2x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat2x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat3x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[2]\w = 0.0
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat3x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = 0.0
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat3x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = m\v[2]\w
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat4x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[2]\w = 0.0
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat4x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = 0.0
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat4x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = m\v[2]\w
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat2x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat2x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat2x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat3x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = 0.0
res\column[3]\y = 0.0
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat3x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = 0.0
res\column[3]\y = 0.0
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat3x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = 0.0
res\column[3]\y = 0.0
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat4x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat4x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat4x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat2x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat2x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat2x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat3x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat3x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat3x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat4x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = 0.0
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat4x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = m\v[3]\z
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat4x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = m\v[3]\z
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat2x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat2x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat2x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = 0.0
res\column[2]\y = 0.0
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat3x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat3x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = 0.0
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat3x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = m\v[2]\w
res\column[3]\x = 0.0
res\column[3]\y = 0.0
res\column[3]\z = 0.0
res\column[3]\w = 1.0
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x2) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = 0.0
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = 0.0
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = 1.0
res\column[2]\w = 0.0
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = 0.0
res\column[3]\w = 1.0
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x3) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = 0.0
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = 0.0
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = 0.0
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = m\v[3]\z
res\column[3]\w = 1.0
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x4) <<8)
res\column[0]\x = m\v[0]\x
res\column[0]\y = m\v[0]\y
res\column[0]\z = m\v[0]\z
res\column[0]\w = m\v[0]\w
res\column[1]\x = m\v[1]\x
res\column[1]\y = m\v[1]\y
res\column[1]\z = m\v[1]\z
res\column[1]\w = m\v[1]\w
res\column[2]\x = m\v[2]\x
res\column[2]\y = m\v[2]\y
res\column[2]\z = m\v[2]\z
res\column[2]\w = m\v[2]\w
res\column[3]\x = m\v[3]\x
res\column[3]\y = m\v[3]\y
res\column[3]\z = m\v[3]\z
res\column[3]\w = m\v[3]\w
    CompilerDefault
      CompilerError "[set] unsupported type"
  CompilerEndSelect
EndMacro
Macro Scalar_let(res, s, op, m)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(m\__type0__)&1)<<0) +((TypeOf(m\__type1__)&1)<<1) +((TypeOf(m\__type2__)&1)<<2) + ((TypeOf(m\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
res\x =(s) op m\x
res\y =(s) op m\y
res\z =(s) op m\z
res\w =(s) op m\w
    CompilerCase math::#type_vec2
res\x =(s) op m\x
res\y =(s) op m\y
    CompilerCase math::#type_vec3
res\x =(s) op m\x
res\y =(s) op m\y
res\z =(s) op m\z
    CompilerCase math::#type_vec4
res\x =(s) op m\x
res\y =(s) op m\y
res\z =(s) op m\z
res\w =(s) op m\w
    CompilerCase math::#type_Mat2x2
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
    CompilerCase math::#type_Mat2x3
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
    CompilerCase math::#type_Mat2x4
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[0]\w =(s) op m\column[0]\w
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[1]\w =(s) op m\column[1]\w
    CompilerCase math::#type_Mat3x2
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
    CompilerCase math::#type_Mat3x3
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[2]\z =(s) op m\column[2]\z
    CompilerCase math::#type_Mat3x4
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[0]\w =(s) op m\column[0]\w
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[1]\w =(s) op m\column[1]\w
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[2]\z =(s) op m\column[2]\z
res\column[2]\w =(s) op m\column[2]\w
    CompilerCase math::#type_Mat4x2
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[3]\x =(s) op m\column[3]\x
res\column[3]\y =(s) op m\column[3]\y
    CompilerCase math::#type_Mat4x3
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[2]\z =(s) op m\column[2]\z
res\column[3]\x =(s) op m\column[3]\x
res\column[3]\y =(s) op m\column[3]\y
res\column[3]\z =(s) op m\column[3]\z
    CompilerCase math::#type_Mat4x4
res\column[0]\x =(s) op m\column[0]\x
res\column[0]\y =(s) op m\column[0]\y
res\column[0]\z =(s) op m\column[0]\z
res\column[0]\w =(s) op m\column[0]\w
res\column[1]\x =(s) op m\column[1]\x
res\column[1]\y =(s) op m\column[1]\y
res\column[1]\z =(s) op m\column[1]\z
res\column[1]\w =(s) op m\column[1]\w
res\column[2]\x =(s) op m\column[2]\x
res\column[2]\y =(s) op m\column[2]\y
res\column[2]\z =(s) op m\column[2]\z
res\column[2]\w =(s) op m\column[2]\w
res\column[3]\x =(s) op m\column[3]\x
res\column[3]\y =(s) op m\column[3]\y
res\column[3]\z =(s) op m\column[3]\z
res\column[3]\w =(s) op m\column[3]\w
    CompilerDefault
      CompilerError "[scalar_let] unsupported type"
  CompilerEndSelect
EndMacro
Macro let_Scalar(res, m, op, s)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(m\__type0__)&1)<<0) +((TypeOf(m\__type1__)&1)<<1) +((TypeOf(m\__type2__)&1)<<2) + ((TypeOf(m\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
res\w = m\w op(s)
res\x = m\x op(s)
res\y = m\y op(s)
res\z = m\z op(s)
    CompilerCase math::#type_vec2
res\x = m\x op(s)
res\y = m\y op(s)
    CompilerCase math::#type_vec3
res\x = m\x op(s)
res\y = m\y op(s)
res\z = m\z op(s)
    CompilerCase math::#type_vec4
res\x = m\x op(s)
res\y = m\y op(s)
res\z = m\z op(s)
res\w = m\w op(s)
    CompilerCase math::#type_Mat2x2
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
    CompilerCase math::#type_Mat2x3
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
    CompilerCase math::#type_Mat2x4
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[0]\w = m\column[0]\w op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[1]\w = m\column[1]\w op(s)
    CompilerCase math::#type_Mat3x2
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
    CompilerCase math::#type_Mat3x3
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[2]\z = m\column[2]\z op(s)
    CompilerCase math::#type_Mat3x4
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[0]\w = m\column[0]\w op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[1]\w = m\column[1]\w op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[2]\z = m\column[2]\z op(s)
res\column[2]\w = m\column[2]\w op(s)
    CompilerCase math::#type_Mat4x2
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[3]\x = m\column[3]\x op(s)
res\column[3]\y = m\column[3]\y op(s)
    CompilerCase math::#type_Mat4x3
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[2]\z = m\column[2]\z op(s)
res\column[3]\x = m\column[3]\x op(s)
res\column[3]\y = m\column[3]\y op(s)
res\column[3]\z = m\column[3]\z op(s)
    CompilerCase math::#type_Mat4x4
res\column[0]\x = m\column[0]\x op(s)
res\column[0]\y = m\column[0]\y op(s)
res\column[0]\z = m\column[0]\z op(s)
res\column[0]\w = m\column[0]\w op(s)
res\column[1]\x = m\column[1]\x op(s)
res\column[1]\y = m\column[1]\y op(s)
res\column[1]\z = m\column[1]\z op(s)
res\column[1]\w = m\column[1]\w op(s)
res\column[2]\x = m\column[2]\x op(s)
res\column[2]\y = m\column[2]\y op(s)
res\column[2]\z = m\column[2]\z op(s)
res\column[2]\w = m\column[2]\w op(s)
res\column[3]\x = m\column[3]\x op(s)
res\column[3]\y = m\column[3]\y op(s)
res\column[3]\z = m\column[3]\z op(s)
res\column[3]\w = m\column[3]\w op(s)
    CompilerDefault
      CompilerError "[let_Scalar] unsupported type"
  CompilerEndSelect
EndMacro
Macro div(res, m1, m2)
CompilerSelect(((((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3))) +((((TypeOf(m1\__type0__)&1)<<0) +((TypeOf(m1\__type1__)&1)<<1) +((TypeOf(m1\__type2__)&1)<<2) +((TypeOf(m1\__type3__)&1)<<3))) <<8 +((((TypeOf(m2\__type0__)&1)<<0) +((TypeOf(m2\__type1__)&1)<<1) +((TypeOf(m2\__type2__)&1)<<2) + ((TypeOf(m2\__type3__)&1)<<3)))<<16)
CompilerCase ((math::#type_vec2) +(math::#type_Mat2x2) <<8 +(math::#type_vec2) <<16); mat vec
      math::Mat2x2_div_Vec2(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_Mat3x3) <<8 +(math::#type_vec3) <<16)
      math::Mat3x3_div_Vec3(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_Mat4x4) <<8 +(math::#type_vec4) <<16)
      math::Mat4x4_div_Vec4(res, m1, m2)
    CompilerDefault
CompilerCase ((math::#type_vec2) +(math::#type_vec2) <<8 +(math::#type_Mat2x2) <<16); mat/vec
      math::Vec2_div_Mat2x2(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8 +(math::#type_Mat3x3) <<16)
      math::Vec3_div_Mat3x3(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8 +(math::#type_Mat4x4) <<16)
      math::Vec4_div_Mat4x4(res, m1, m2)
CompilerCase ((math::#type_vec2) +(math::#type_vec2) <<8 +(math::#type_vec2) <<16); vec
res\x = m1\x / m2\x
res\y = m1\y / m2\y
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8 +(math::#type_vec3) <<16)
res\x = m1\x / m2\x
res\y = m1\y / m2\y
res\z = m1\z / m2\z
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8 +(math::#type_vec4) <<16)
res\x = m1\x / m2\x
res\y = m1\y / m2\y
res\z = m1\z / m2\z
res\w = m1\w / m2\w
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x2) <<8 +(math::#type_Mat2x2) <<16); mat
      math::Mat2x2_div(res, m1, m2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x3) <<8 +(math::#type_Mat3x3) <<16)
      math::Mat3x3_div(res, m1, m2)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x4) <<8 +(math::#type_Mat4x4) <<16)
      math::Mat4x4_div(res, m1, m2)
    CompilerDefault
      CompilerError "[div] unsupported type"
  CompilerEndSelect
EndMacro
Macro let(res, v1, op, v2)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v1\__type0__)&1)<<0) +((TypeOf(v1\__type1__)&1)<<1) +((TypeOf(v1\__type2__)&1)<<2) +((TypeOf(v1\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v2\__type0__)&1)<<0) +((TypeOf(v2\__type1__)&1)<<1) +((TypeOf(v2\__type2__)&1)<<2) + ((TypeOf(v2\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_vec2
res\x = v1\x op v2\x
res\y = v1\y op v2\y
    CompilerCase math::#type_vec3
res\x = v1\x op v2\x
res\y = v1\y op v2\y
res\z = v1\z op v2\z
    CompilerCase math::#type_vec4
res\x = v1\x op v2\x
res\y = v1\y op v2\y
res\z = v1\z op v2\z
res\w = v1\w op v2\w
    CompilerDefault      
      CompilerSelect _math::sq#op#_math::sq
        CompilerCase '+'
          add(res,v1,v2)
        CompilerCase '-'
          sub(res,v1,v2)
        CompilerCase '*'
          mul(res,v1,v2)
        CompilerCase '/'
          div(res,v1,v2)
      CompilerEndSelect 
  CompilerEndSelect
EndMacro
Macro inverse(res, m)  
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(M\__type0__)&1)<<0) +((TypeOf(M\__type1__)&1)<<1) +((TypeOf(M\__type2__)&1)<<2) + ((TypeOf(M\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_inverse(res, M)
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_inverse(res, m)       
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_inverse(res, m)       
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_inverse(res, m)       
    CompilerDefault
      Debug "[inverse] Not supported type"
  CompilerEndSelect  
EndMacro
Macro transpose(res, m)  
CompilerSelect(((((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3))) +((((TypeOf(m\__type0__)&1)<<0) +((TypeOf(m\__type1__)&1)<<1) +((TypeOf(m\__type2__)&1)<<2) + ((TypeOf(m\__type3__)&1)<<3)))<<8)
CompilerCase ((math::#type_mat2x2) +(math::#type_mat2x2) <<8)
      math::mat2x2_transpose(res, m)
CompilerCase ((math::#type_mat2x3) +(math::#type_mat3x2) <<8)
      math::mat2x3_transpose(res, m)      
CompilerCase ((math::#type_mat2x4) +(math::#type_mat4x2) <<8)
      math::mat2x4_transpose(res, m)
CompilerCase ((math::#type_mat3x2) +(math::#type_mat2x3) <<8)
      math::mat3x2_transpose(res, m)
CompilerCase ((math::#type_mat3x3) +(math::#type_mat3x3) <<8)
      math::mat3x3_transpose(res, m)
CompilerCase ((math::#type_mat3x4) +(math::#type_mat4x3) <<8)
      math::mat3x4_transpose(res, m)
CompilerCase ((math::#type_mat4x2) +(math::#type_mat2x4) <<8)
      math::mat4x2_transpose(res, m)
CompilerCase ((math::#type_mat4x3) +(math::#type_mat3x4) <<8)
      math::mat4x3_transpose(res, m)
CompilerCase ((math::#type_mat4x4) +(math::#type_mat4x4) <<8)
      math::mat4x4_transpose(res, m)
    CompilerDefault
      CompilerError "[transpose] Not supported mat"
  CompilerEndSelect  
EndMacro
Macro determinant(m)
_math::compute_determinant(m,(((TypeOf(m\__type0__)&1)<<0) +((TypeOf(m\__type1__)&1)<<1) +((TypeOf(m\__type2__)&1)<<2) + ((TypeOf(m\__type3__)&1)<<3)))
EndMacro
Macro cross(res, x, y)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) +((TypeOf(x\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(y\__type0__)&1)<<0) +((TypeOf(y\__type1__)&1)<<1) +((TypeOf(y\__type2__)&1)<<2) + ((TypeOf(y\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase  math::#type_vec3      
      math::Vec3_Cross(res, x, y)
    CompilerCase math::#type_quat
      math::quat_cross(res, x, y)
    Default
      CompilerError("[cross] Type Mismatch")
  CompilerEndSelect
EndMacro
Macro dot(a, b)
_math::compute_Dot(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), b)
EndMacro
Macro length(a)
Sqr(_math::compute_Dot(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), a))
EndMacro
Macro length2(a)
_math::compute_Dot(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), a)
EndMacro
Macro normalize(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)) = math::#type_quat
    math::quat_normalize(res, v)
  CompilerElse
_math::compute_normalize(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), v)
  CompilerEndIf
EndMacro
;}
;-----------------------
;- func_trigonometric.pbi
;{

Declare.f radians_f(x.f)
Declare.f degrees_f(x.f)
Declare.f sin_f(x.f)
Declare.f Cos_f(x.f)
Declare.f tan_f(x.f)
Declare.f asin_f(x.f)
Declare.f acos_f(x.f)
Declare.f ATan2_f(y.f, x.f)
Declare.f SinH_f(x.f)
Declare.f CosH_f(x.f)
Declare.f TanH_f(x.f)
Declare.f ASinH_f(x.f)
Declare.f acosh_f(x.f)
Declare.f ATanH_f(x.f)
Macro radians(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@radians_f(), v)
EndMacro
Macro degrees(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@degrees_f(), v)
EndMacro
Macro Sin(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sin_f(), v)
EndMacro
Macro Cos(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@Cos_f(), v)
EndMacro
Macro Tan(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@tan_f(), v)
EndMacro
Macro ASin(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@asin_f(), v)
EndMacro
Macro ACos(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acos_f(), v)
EndMacro
Macro ATan(res, v, u)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) +((TypeOf(v\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(u\__type0__)&1)<<0) +((TypeOf(u\__type1__)&1)<<1) +((TypeOf(u\__type2__)&1)<<2) + ((TypeOf(u\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@atan_f(), v, u)
EndMacro
Macro SinH(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@SinH_f(), v)
EndMacro
Macro CosH(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@CosH_f(), v)
EndMacro
Macro TanH(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@TanH_f(), v)
EndMacro
Macro ASinH(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@ASinH_f(), v)
EndMacro
Macro ACosH(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acosh_f(), v)
EndMacro
Macro ATanH(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@ATanH_f(), v)
EndMacro
;}
  ; exclude func_packing
  ; exclude func_integer
  ;ext
;-----------------------
;- matrix_clip_space.pbi
;{

Declare ortho2(*res.mat4x4, left.f, right.f, bottom.f, top.f)
Declare orthoLH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoLH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoRH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoRH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoNO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoLH(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoRH(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare ortho(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare frustumLH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumLH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumRH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumRH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumNO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumLH(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumRH(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustum(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare perspectiveRH_ZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveRH_NO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveLH_ZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveLH_NO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveNO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveLH(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveRH(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspective(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveFovRH_ZO(*res.mat4x4, fov.f, width.f, height.f, zNear.f, zFar.f)
Declare perspectiveFovRH_NO(*res.mat4x4, fov.f, width.f, height.f, zNear.f, zFar.f)
Declare perspectiveFovLH_ZO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovLH_NO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovZO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovNO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovLH(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovRH(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFov(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare infinitePerspectiveRH(*res.mat4x4, fovy.f, aspect.f, zNear.f)
Declare infinitePerspectiveLH(*res.mat4x4, fovy.f, aspect.f, zNear.f)
Declare infinitePerspective(*res.mat4x4, fovy.f, aspect.f, zNear.f)
Declare tweakedInfinitePerspective(*res.mat4x4, fovy.f, aspect.f, zNear.f, ep.f=#epsilon)
;}
;-----------------------
;- matrix_projection.pbi
;{

Declare projectZO(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare projectNO(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare project(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare unProjectZO(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare unProjectNO(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare unProject(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare pickMatrix(*res.mat4x4, *center.vec2, *delta.vec2, *viewport.vec4)
;}
;-----------------------
;- matrix_transform.pbi
;{

Declare translate(*res.mat4x4, *m.mat4x4, *v.vec3)
Declare mat4x4_rotate(*res.mat4x4, *m.mat4x4, angle.f, *v.vec3)
Declare rotate_slow(*res.mat4x4, *m.mat4x4, angle.f, *v.vec3)
Declare scale(*res.mat4x4, *m.mat4x4, *v.vec3)
Declare scale_slow(*res.mat4x4, *m.mat4x4, *v.vec3)
Declare mat4x4_lookAtRH(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
Declare mat4x4_lookAtLH(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
Declare mat4x4_lookAt(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
Macro rotate(res,m, anglef, vec3)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(m\__type0__)&1)<<0) +((TypeOf(m\__type1__)&1)<<1) +((TypeOf(m\__type2__)&1)<<2) + ((TypeOf(m\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_rotate(res,m, anglef, vec3)
    CompilerCase math::#type_mat4x4
      math::mat4x4_rotate(res,m, anglef, vec3)
    CompilerDefault
      CompilerError "[rotate] only support mat4x4 and quat"
  CompilerEndSelect
EndMacro
Macro LookAt(resQuatOrMat4x4, DirectionOrEye_Vec3, UpOrCenter_vec3, noneOrUp_vec3=)
CompilerSelect(((TypeOf(resQuatOrMat4x4\__type0__)&1)<<0) +((TypeOf(resQuatOrMat4x4\__type1__)&1)<<1) +((TypeOf(resQuatOrMat4x4\__type2__)&1)<<2) + ((TypeOf(resQuatOrMat4x4\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_LookAt(resQuatOrMat4x4, DirectionOrEye_Vec3, UpOrCenter_vec3)
    CompilerCase math::#type_mat4x4
      math::mat4x4_lookAt(resQuatOrMat4x4, DirectionOrEye_Vec3, UpOrCenter_vec3, noneOrUp_vec3)
    CompilerDefault
      CompilerError "[LookAt] only supports quat and mat4x4"
  CompilerEndSelect
EndMacro
Macro LookAtRH(resQuatOrMat4x4, DirectionOrEye_Vec3, UpOrCenter_vec3, noneOrUp_vec3=)
CompilerSelect(((TypeOf(resQuatOrMat4x4\__type0__)&1)<<0) +((TypeOf(resQuatOrMat4x4\__type1__)&1)<<1) +((TypeOf(resQuatOrMat4x4\__type2__)&1)<<2) + ((TypeOf(resQuatOrMat4x4\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_LookAtRH(resQuatOrMat4x4, DirectionOrEye_Vec3, UpOrCenter_vec3)
    CompilerCase math::#type_mat4x4
      math::mat4x4_lookAtRH(resQuatOrMat4x4, DirectionOrEye_Vec3, UpOrCenter_vec3, noneOrUp_vec3)
    CompilerDefault
      CompilerError "[LookAt] only supports quat and mat4x4"
  CompilerEndSelect
EndMacro
Macro LookAtLH(resQuatOrMat4x4, DirectionOrEye_Vec3, UpOrCenter_vec3, noneOrUp_vec3=)
CompilerSelect(((TypeOf(resQuatOrMat4x4\__type0__)&1)<<0) +((TypeOf(resQuatOrMat4x4\__type1__)&1)<<1) +((TypeOf(resQuatOrMat4x4\__type2__)&1)<<2) + ((TypeOf(resQuatOrMat4x4\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_LookAtLH(resQuatOrMat4x4, DirectionOrEye_Vec3, UpOrCenter_vec3)
    CompilerCase math::#type_mat4x4
      math::mat4x4_lookAtLH(resQuatOrMat4x4, DirectionOrEye_Vec3, UpOrCenter_vec3, noneOrUp_vec3)
    CompilerDefault
      CompilerError "[LookAt] only supports quat and mat4x4"
  CompilerEndSelect
EndMacro
;}
;-----------------------
;- quaternion.pbi
;{

#type_quat = 1
Structure Quat
  _math_::StructureAddType(#type_quat)
  StructureUnion
    w.f
    f.f[0]
  EndStructureUnion
  StructureUnion
    x.f  
  EndStructureUnion
  StructureUnion
    y.f  
  EndStructureUnion
  StructureUnion
    z.f    
  EndStructureUnion
EndStructure
Structure QuatL
  _math_::StructureAddType(#type_quat)
  StructureUnion
    w.l
    l.l[0]
  EndStructureUnion
  StructureUnion
    x.l  
  EndStructureUnion
  StructureUnion
    y.l  
  EndStructureUnion
  StructureUnion
    z.l    
  EndStructureUnion
EndStructure
;}
;-----------------------
;- type_quat.pbi
;{

Macro quat_set(res, wf=1.0, xf=0.0, yf=0.0, zf=0.0)
  res\x = xf
  res\y = yf
  res\z = zf
  res\w = wf
EndMacro
Macro quat_const(label, wf,xf, yf, zf)
  DataSection
    label:
    Data.f wf, xf, yf, zf
  EndDataSection
EndMacro
Macro quat_set_Scalar(res, s)
  res\w = (s)
  res\x = (s)
  res\y = (s)
  res\z = (s)  
EndMacro
Macro quat_set_quat(res, v)
  res\w = v\w
  res\x = v\x
  res\y = v\y
  res\z = v\z  
EndMacro
Macro quat_set_f_vec3(res,s,v)
  res\w = s
  res\x = v\x
  res\y = v\y
  res\z = v\z
EndMacro
Declare quat_set_vec3_vec3(*res.quat, *u.vec3, *v.vec3)
Declare quat_set_eulerAngle(*res.quat, *eulerAngle.vec3)
Declare quat_set_mat3x3(*res.quat, *m.mat3x3)
Declare quat_set_mat4x4(*res.quat, *m.mat4x4)
Declare mat3x3_set_quat(*res.mat3x3, *q.quat)
Declare mat4x4_set_quat(*res.mat4x4, *q.quat)
; Macro vec4_let(res,v1, op, v2)
;   res\x = v1\x op v2\x
;   res\y = v1\y op v2\y
;   res\z = v1\z op v2\z
;   res\w = v1\w op v2\w
; EndMacro
Macro quat_let_Scalar(res, v, op, s)
  res\w = v\w op (s)
  res\x = v\x op (s)
  res\y = v\y op (s)
  res\z = v\z op (s)  
EndMacro
Macro Scalar_let_quat(res, s, op, v)
  res\x = (s) op v\x 
  res\y = (s) op v\y 
  res\z = (s) op v\z 
  res\w = (s) op v\w 
EndMacro
Macro quat_add(res, q, p)
  res\w = q\w + p\w
  res\x = q\x + p\x
  res\y = q\y + p\y
  res\z = q\z + p\z
EndMacro
Macro quat_sub(res, q, p)
  res\w = q\w - p\w
  res\x = q\x - p\x
  res\y = q\y - p\y
  res\z = q\z - p\z
EndMacro
Declare quat_mul(*res.quat, *q.quat, *p.quat)
Declare quat_mul_vec3(*res.vec3, *q.quat, *v.vec3)
Declare vec3_mul_quat(*res.vec3, *v.vec3, *q.quat)
Declare quat_mul_vec4(*res.vec4, *q.quat, *v.vec4)
Declare vec4_mul_quat(*res.vec4, *v.vec4, *q.quat)
Macro quat_isEqual(q, p)
  Bool(q\w=p\w And q\x=p\x And q\y=p\y And q\z=p\z
EndMacro
;}
;-----------------------
;- quaternion_common.pbi
;{

Declare quat_mix(*res.quat, *x.quat, *y.quat, a.f)
Declare lerp(*res.quat, *x.quat, *y.quat, a.f)
Declare slerp(*res.quat, *x.quat, *y.quat, a.f, k.f = 0)
Declare quat_inverse(*res.quat, *q.quat)
Macro conjugate(res, quat)
  res\w = quat\w
  res\x = -quat\x
  res\y = -quat\y
  res\z = -quat\z
EndMacro
;}
;-----------------------
;- quaternion_geometric.pbi
;{

Declare quat_normalize(*res.quat, *q.quat)
Declare quat_cross(*res.quat, *q1.quat, *q2.quat)
;}
;-----------------------
;- quaternion_exponential.pbi
;{

Declare quat_exp(*res.quat, *q.quat)
Declare quat_pow(*res.quat, *x.quat, y.f)
Declare quat_Log(*res.quat, *q.quat)
Declare quat_sqrt(*res.quat, *q.quat)
;}
;-----------------------
;- quaternion_transform.pbi
;{

Declare quat_rotate(*res.quat, *q.quat, angle.f, *v.vec3)
;}
;-----------------------
;- quaternion_trigonometric.pbi
;{

Declare.f angle(*x.quat)
Declare axis(*res.vec3, *x.quat)
Declare angleAxis(*res.quat, angle.f, *v.vec3)
;}
;-----------------------
;- scalar_reciprocal.pbi
;{

Declare.f sec_f(angle.f)
Declare.f csc_f(angle.f)
Declare.f cot_f(angle.f)
Declare.f asec_f(x.f)
Declare.f acsc_f(x.f)
Declare.f acot_f(x.f)
Declare.f sech_f(angle.f)
Declare.f csch_f(angle.f)
Declare.f coth_f(angle.f)
Declare.f asech_f(x.f)
Declare.f acsch_f(x.f)
Declare.f acoth_f(x.f)
Macro sec(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sec_f(), v)
EndMacro
Macro csc(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@csc_f(), v)
EndMacro
Macro cot(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@cot_f(), v)
EndMacro
Macro asec(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@asec_f(), v)
EndMacro
Macro acsc(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acsc_f(), v)
EndMacro
Macro acot(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acot_f(), v)
EndMacro
Macro sech(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sech_f(), v)
EndMacro
Macro csch(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@csch_f(), v)
EndMacro
Macro coth(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@coth_f(), v)
EndMacro
Macro asech(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@asech_f(), v)
EndMacro
Macro acsch(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acsch_f(), v)
EndMacro
Macro acoth(res, v)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(v\__type0__)&1)<<0) +((TypeOf(v\__type1__)&1)<<1) +((TypeOf(v\__type2__)&1)<<2) + ((TypeOf(v\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acoth_f(), v)
EndMacro
;}
;-----------------------
;- quatemion.pbi
;{

Macro Roll(quat)
  _math::_Roll(quat)
EndMacro
Macro Pitch(quat)
  _math::_Pitch(quat)
EndMacro
Macro Yaw(quat)
  _math::_Yaw(quat)
EndMacro
Declare eulerAngles(*res.vec3, *x.quat)
Declare quat_LookAt(*res.quat, *direction.vec3, *up.vec3)
Declare quat_LookAtRH(*res.quat, *direction.vec3, *up.vec3)
Declare quat_LookAtLH(*res.quat, *direction.vec3, *up.vec3)
;}
EndDeclareModule
XIncludeFile "_module__math_.pbi"
XIncludeFile "_declare__math.pbi"
XIncludeFile "_module__math.pbi"
XIncludeFile "_module_math.pbi"
