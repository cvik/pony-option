class Option[T]
  var _val: (T | None)

  new create(v: (T | None) = None) => _val = consume v
  fun ref update(value: (T | None)) => _val = consume value

  fun apply(default: (this->T^|None) = None): this->T ? =>
    match _val
    | let v: this->T => v
    | None =>
      match default
      | None => error
      | let d: this->T => d
      end
    end

  fun is_none(): Bool => _val is None
  fun is_some(): Bool => not (_val is None)

  fun contains(v: T^, f: {(box->T!, box->T!): Bool}): Bool =>
    match _val
    | None => false
    | let u: this->T! => f(u, v)
    end


  fun map[V: V](f: {(box->T!): V^}): Option[V]^ =>
    match _val
    | None => Option[V]()
    | let t: this->T! => Option[V](f(consume t))
    end

  fun map_or[V: V](v: V^, f: {(box->T!): V^}): V^ =>
    match _val
    | None => v
    | let w: this->T! => f(consume w)
    end

  fun and_also(opt: Option[T]): Option[T]^ =>
    match _val
    | None => Option[T]()
    else opt
    end

  fun and_then(f: {(box->T!): Option[T]^}): Option[T]^ =>
    match _val
    | None => Option[T]()
    | let v: this->T! => f(consume v)
    end

 fun or_else(opt: this->Option[T]^): this->Option[T]^ =>
    match _val
    | None => opt
    else this // maybe create a new instance here?
    end

  fun or_then(f: {(): box->Option[T]^}):box->Option[T]^ =>
    match _val
    | None => f()
    else this
    end

/*
  fun flatten(): Option[T]^ =>
    match _val
    | let o: Option[T] => o.flatten()
    | None => Option[T]()
    | let v: this->T! => Option[T](consume v)
    end
*/
