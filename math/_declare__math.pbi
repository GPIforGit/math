DeclareModule _math
  EnableExplicit
  Macro dq
    "
  EndMacro
  Macro sq
    '
  EndMacro
;-----------------------
;- _func_common.pbi
;{

Prototype.f prot_function1(x.f)
Prototype.f prot_function2(x.f,y.f)
Prototype.f prot_function2p(x.f,*y.float)
Prototype.f prot_function3(x.f,y.f,z.f)
Prototype prot_cmp(*res.long, resType.l, *m1.float, *m2.float, epsilon.f)     
Declare vec_Step_Vector(*res.math::vec4, resType.l, *edge.math::vec4, *x.math::vec4)
Declare vec_Step_Vector_Scalar(*res.math::vec4, resType.l, edge.f, *x.math::vec4)
Declare vec_smoothstep_vector(*res.math::vec4, resType.l, *edge0.math::vec4, *edge1.math::vec4, *x.math::vec4)
Declare vec_smoothstep_vector_Scalar(*res.math::vec4, resType.l, edge0.f, edge1.f, *x.math::vec4)
Declare.s string(*res.float, resType.l, NbDecimals.f)
Declare.s stringBool(*res.long, resType.l)
Declare Is_NAN(*resbool.long, resType.l, *x.float)
Declare is_Inf(*resbool.long, resType.l, *x.float)
Declare.l bool_any(*res.long, resType)
Declare.l bool_all(*res.long, resType)
Declare bool_not(*res.long, resType, *x.long)
Declare bool_and(*res.long, resType.l, *m1.long, *m2.long)
Declare bool_or(*res.long, resType.l, *m1.long, *m2.long)
Declare.l do_all(*func.prot_cmp, resType.l, *m1.float, *m2.float, epsilon.f)
Declare.l do_any(*func.prot_cmp, resType.l, *m1.float, *m2.float, epsilon.f)
Declare equal(*res.long, resType.l, *m1.float, *m2.float, epsilon.f)
Declare notequal(*res.long, resType.l, *m1.float, *m2.float, epsilon.f)
Declare lessThan(*res.long, resType.l, *m1.float, *m2.float)
Declare lessThanEqual(*res.long, resType.l, *m1.float, *m2.float)
Declare greaterThan(*res.long, resType.l, *m1.float, *m2.float)
Declare greaterThanEqual(*res.long, resType.l, *m1.float, *m2.float)
Declare long_from_float(*l.long, resType, *f.float)
Declare float_from_long(*f.float, resType, *l.long)
Declare compute_mix_scalar(*res.float, resType.l, *x.float, *y.float, a.f)
Declare compute_mix(*res.float, resType.l, *x.float, *y.float, *a.float)
Declare compute_function1(*res.float, resType.l, *func1.prot_function1, *x.float)
Declare compute_function2(*res.float, resType.l, *func2.prot_function2, *x.float, *y.float)
Declare compute_function2p(*res.float, resType.l, *func2.prot_function2p, *x.float, *y.float)
Declare compute_function2s(*res.float, resType.l, *func2.prot_function2, *x.float, y.f)
Declare compute_function3(*res.float, resType.l, *func3.prot_function3, *x.float, *y.float, *z.float)
Declare compute_function3s(*res.float, resType.l, *func3.prot_function3, *x.float, y.f, z.f)
Declare.f min_f(a.f, b.f, c.f, d.f)
Declare.f min2_f(a.f, b.f)
Declare.f max_f(a.f, b.f, c.f, d.f)
Declare.f max2_f(a.f, b.f)
;}
;-----------------------
;- _func_geometric.pbi
;{

Declare.f compute_Dot(*a.math::vec4, aType.l, *b.math::vec4)
Declare.f compute_distance2(*a.float, aType.l, *b.float)
Declare compute_normalize(*res.math::vec4, resType.l, *v.math::vec4)
Declare compute_faceforward(*res.math::vec4, resType.l, *n.math::vec4, *i.math::vec4, *nref.math::vec4)
Declare compute_reflect(*res.math::vec4, resType.l, *i.math::vec4, *n.math::vec4)
Declare compute_refract(*res.math::vec4, resType.l, *I.math::vec4, *N.math::vec4, eta.f)
;}
;-----------------------
;- _func_matrix.pbi
;{

Declare compute_matrixCompMult(*res.float, resType.l, *x.float, *y.float)
Declare compute_outerProduct(*res.float, resType.l, *c.math::vec4, *r.math::vec4)
Declare.f compute_determinant(*res, resType.l)
;}
;-----------------------
;- _quatemion.pbi
;{

Declare.f _Roll(*q.math::quat)
Declare.f _Pitch(*q.math::quat)
Declare.f _Yaw(*q.math::quat)
;}
  CompilerIf #PB_Compiler_Debugger
    Macro assert(exp)
      If Not( exp )
        CallDebugger
      EndIf
    EndMacro
  CompilerElse
    Macro assert(exp)
    EndMacro
  CompilerEndIf
  Macro OnlyVecType(v1)
    CompilerIf math::GetType(v1) > math::#type_vecmax 
      CompilerError "Type must be vector!"
    CompilerEndIf
  EndMacro  
  Macro OnlyMatType(v1)
    CompilerIf math::GetType(v1) < math::#type_vecmax 
      CompilerError "Type must be vector!"
    CompilerEndIf
  EndMacro  
  Macro SameType2(v1, v2)
    CompilerIf math::GetType(v1) <> math::GetType(v2)
      CompilerError "Types must be the same!"
    CompilerEndIf
  EndMacro
  Macro SameType3(v1, v2, v3)
    CompilerIf math::GetType(v1) <> math::GetType(v2) Or math::GetType(v1) <> math::GetType(v3)
      CompilerError "Types must be the same!"
    CompilerEndIf
  EndMacro
  Macro SameType4(v1, v2, v3, v4)
    CompilerIf math::GetType(v1) <> math::GetType(v2) Or math::GetType(v1) <> math::GetType(v3) Or math::GetType(v1) <> math::GetType(v4)
      CompilerError "Types must be the same!"
    CompilerEndIf
  EndMacro
  Macro TypeList2(x, y)
    ((x) + (y) <<8)
  EndMacro
  Macro TypeList2Size(x,y)
    ((math::GetType(x)) + (math::GetType(y))<<8)
  EndMacro
  Macro TypeList3(x, y, z)
    ((x) + (y) <<8 + (z) <<16)
  EndMacro
  Macro TypeList3Size(x,y,z)
    ((math::GetType(x)) + (math::GetType(y)) <<8 + (math::GetType(z))<<16)
  EndMacro
  Macro adrMat(adr,col,row,maxrow)
    (adr + (col * maxrow + row)*SizeOf(float))
  EndMacro
  Global Dim matCol.l(math::#type_matMAX)
  Global Dim matRow.l(math::#type_matMAX)
  Global Dim matFloatSize.l(math::#type_matMax)
  matCol(math::#type_Mat2x2) = 2 : matRow(math::#type_Mat2x2) = 2
  matCol(math::#type_Mat2x3) = 2 : matRow(math::#type_Mat2x3) = 3
  matCol(math::#type_Mat2x4) = 2 : matRow(math::#type_Mat2x4) = 4
  matCol(math::#type_Mat3x2) = 3 : matRow(math::#type_Mat3x2) = 2
  matCol(math::#type_Mat3x3) = 3 : matRow(math::#type_Mat3x3) = 3
  matCol(math::#type_Mat3x4) = 3 : matRow(math::#type_Mat3x4) = 4
  matCol(math::#type_Mat4x2) = 4 : matRow(math::#type_Mat4x2) = 2
  matCol(math::#type_Mat4x3) = 4 : matRow(math::#type_Mat4x3) = 3
  matCol(math::#type_Mat4x4) = 4 : matRow(math::#type_Mat4x4) = 4
EndDeclareModule
