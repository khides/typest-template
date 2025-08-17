#import "useful_functions.typ": *
#import "my_short_hand.typ": *
#import "@preview/physica:0.9.3": *
// #import "@preview/metro:0.3.0" : *


#let phantom-paragraph() = {
  set text(size: 10pt)
  let a = par(box())
  a
  context v(-0.8 * measure(2 * a).width)
}

#let project(
  title: "",
  title-header: "",
  datetime: "",
  abstract: none,
  keywords:none,
  JEL: none,
  authors: (),
  institutions: (),
  notes: (),
  date: Today(),
  body-font: ("STIX Two Text","Hiragino Mincho ProN"),
  sans-font: ("STIX Two Text","Hiragino Kaku Gothic ProN"),
  math-font: ("STIX Two Math","Hiragino Mincho ProN"),
  leading: 1.0em,
  lang: "en",
  font-size: 12pt,
  margin: (left:1.0in, top:1.0in, right:0.5in, bottom:0.5in),
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name-ja), title: title)
  set page(
    numbering: "1", 
    number-align: center, 
    margin: margin,
    header: [
      #title-header #h(1fr) #datetime
      #v(-10pt)
      #line(length: 100%)
    ],
    columns: 2,
  )


  // Set body font family.
  set text(font: body-font, lang:lang)
  show heading: set text(font: sans-font)
  set heading(numbering: "1.1", supplement: [Section])
  set footnote(numbering: "*")
  // Title row.
  align(center)[
    #text(font: sans-font, weight: 700, 1.75em)[#title]
  ]
  // Author information.
  align(center)[
    #set text(size: 10.5pt)
    #authors.enumerate().map(i_author => {
      let (i, author) = i_author
      if author.presenting [〇]
      box(author.name-ja)
    }).join("，")
  ]
  // let author_note = authors.zip(notes)
  // pad(
  //   top: 0.5em,
  //   bottom: 0.5em,
  //   x: 2em,
  //   grid(
  //     columns: (1fr,) * calc.min(3, authors.len()),
  //     gutter: 1em,
  //     ..author_note.map(author => align(center, [#author.at(0)#footnote[#author.at(1)]])),
  //     ..institutions.map(institutions => align(center, strong(institutions)))
  //   ),
  // )
  // align(center)[#text(font: body-font, weight: 500, 1em)[#date]]


  // Main body. 基本設定.
  // footnoteの設定
  set footnote(numbering: "1")
  counter(footnote).update(0)
  // paragraphの設定． indent 1em, 行送り1.2em
  set par(justify: true, first-line-indent: 1em, leading: leading)
  // fontの設定
  set text(font: body-font, size:font-size)
  set text(cjk-latin-spacing: auto)

  show emph: set text(font: body-font)
  show strong: set text(font: sans-font)
  //数式フォントの設定
  show math.equation: set text(font: math-font)
  set enum(numbering: "1.a.")
  show ref: it => eq_refstyle(it,lang:lang)
  // set cite(form: "prose")

  
  //定理環境その他の設定
  show figure: it => {
  let c_eq = counter_body(it)
  let thenumber = numbering(
      it.numbering,
      ..c_eq.at(it.location()))
  if it.kind in theo_list{
  let name = cap_body(it.caption)
  my_thm_style(trans.at(lang).at(it.kind), name, thenumber, it.body)
  }
  else if it.kind in defi_list{
  let name = cap_body(it.caption)
  my_defi_style(trans.at(lang).at(it.kind), name, thenumber, it.body)
  }
  else if it.supplement.text in ("Table") {
  align(center)[#trans.at(lang).at(it.supplement.text) #thenumber: #cap_body(it.caption)]
  it.body
  }
  else if it.supplement.text in ("Figure") {
  it.body
  align(center)[#trans.at(lang).at(it.supplement.text) #thenumber: #cap_body(it.caption)]
  }
  
  else if it.kind == "Proof" {
    let name = cap_body(it.caption)
    my_proof_style(trans.at(lang).at(it.kind), name, it.numbering, it.body,lang)}
  else {it}
} 
//Appendixの設定
 
  
//abstractの設定
  
  if abstract != none {
    align(center)[#text(1em, strong[#abstract_name.at(lang)])]
    block(inset: (left:12%, right:12%))[
    #text(0.85em)[#par( leading: 0.5*leading)[#abstract]]]}
  if keywords != none{
    block(width: 100%)[*Keyword:* #keywords]
  if JEL != none {
    block(width: 100%)[*JEL Classification:* #JEL]
  }
  }  

  body
}



