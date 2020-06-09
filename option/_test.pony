use "ponytest"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  fun make() => None

  fun tag tests(test: PonyTest) =>
    test(_TestOptions)


class _TestOptions is UnitTest
  fun name(): String => "options"

  fun apply(h: TestHelper) ? =>
    var x: Option[String] = x.create()
    h.assert_true(x.is_none())

    x() = "hello"
    h.assert_true(x.is_some())
    h.assert_true(x()? == "hello")

    let l: Option[USize] = x.map[USize]({(v: String): USize => v.size()})
    h.assert_true(l()? == 5)

    h.assert_true(l.map_or[USize](10, {(v: USize): USize => v + 2}) == 7)

    l() = None
    h.assert_true(l.map_or[USize](100, {(v: USize): USize => v + 2}) == 100)

    h.assert_true(l.and_also(Option[USize](15)).is_none())
    h.assert_true(l.and_then({(v: USize): Option[USize] => Option[USize](v+2)}).is_none())

    l() = 22
    h.assert_true(l.and_then({(v: USize): Option[USize] => Option[USize](v+2)})()? == 24)

    let y: Option[String] = y.create()
    h.assert_true(y("hi")? == "hi")

    let z: Option[U8] = z.create()
    h.assert_true(z.or_else(Option[U8](6)).contains(6, {(u:U8, v:U8): Bool => u == v}))

    let zw: Option[U8] = z.create(7)
    h.assert_true(zw.or_else(Option[U8](2)).contains(7, {(u:U8, v:U8): Bool => u == v}))

    let xw: Option[U8] = z.create()
    h.assert_true(xw.or_then({(): Option[U8] => Option[U8](12)}).contains(12, {(u:U8, v:U8): Bool => u == v}))

    xw() = 14
    h.assert_true(xw.or_then({(): Option[U8] => Option[U8](12)}).contains(14, {(u:U8, v:U8): Bool => u == v}))

