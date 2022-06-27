
module \74AC251_1x1MUX8 (input A, B, C, D, E, F, G, H, S, T, U, OE_N, output Y);
  wire y_int;
  \74AC151_1x1MUX8 mux(
    .A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .G(G), .H(H),
    .S(S), .T(T), .U(U),
    .Y(y_int)
  );
  assign Y = !OE_N & y_int;
endmodule

module gameoflife(input mid, i0, i1, i2, i3, i4, i5, i6, i7, output alive);
  wire [1:0] sum1;
  wire [1:0] sum2;
  wire s1, s2, s3, s4;
  wire dummy;

  \74AC283_1x1ADD4  add2 (
    .A({i4, i3, 1'b0, i1}),
    .B({i5, i3, 1'b0, i2}),
    .CI(i0),
    .CO(sum1[1]),
    .S({sum1[0], dummy, sum2})
  );
  \74AC283_1x1ADD4  add3 (
    .A({2'b00, sum1}),
    .B({2'b00, sum2}),
    .CI(i6),
    .CO(),
    .S({s4, s3, s2, s1})
  );

  \74AC251_1x1MUX8 mux(
    .A(1'b0), .B(1'b0), .C(mid), .D(1'b1), .E(1'b0), .F(mid), .G(1'b1), .H(1'b0),
    .S(s1), .T(s2), .U(i7), .OE_N(s3),
    .Y(alive)
  );
endmodule

 