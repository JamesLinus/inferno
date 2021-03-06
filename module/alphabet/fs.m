# warning: autogenerated code; don't bother to change this, change mktypeset.b or fs.b instead
Fs: module {
	PATH: con "/dis/alphabet/fs.dis";
	Value: adt {
		r:	fn(v: self ref Value): ref Value.Vr;	# status
		d:	fn(v: self ref Value): ref Value.Vd;	# data
		c:	fn(v: self ref Value): ref Value.Vc;	# command
		f:	fn(v: self ref Value): ref Value.Vf;	# fd
		s:	fn(v: self ref Value): ref Value.Vs;	# string
		m:	fn(v: self ref Value): ref Value.Vm;	# selector
		p:	fn(v: self ref Value): ref Value.Vp;	# gate
		t:	fn(v: self ref Value): ref Value.Vt;	# entries
		x:	fn(v: self ref Value): ref Value.Vx;	# fs
		typec: fn(v: self ref Value): int;
		type2s:	fn(t: int): string;
		free: fn(v: self ref Value, used: int);
		dup:	fn(v: self ref Value): ref Value;
		pick {
		Vr =>
			i: chan of string;
		Vd =>
			i: Datachan;
		Vc =>
			i: ref Sh->Cmd;
		Vf =>
			i: chan of ref Sys->FD;
		Vs =>
			i: string;
		Vm =>
			i: Cmpchan;
		Vp =>
			i: Gatechan;
		Vt =>
			i: Entrychan;
		Vx =>
			i: Fschan;
		}
	};
	init: fn();
	sendnulldir:	fn(c: Fschan): int;
	copy:		fn(src, dst: Fschan): int;
	Option: adt {
		opt: int;
		args: list of ref Value;
	};
	Datachan: adt {
		d: chan of array of byte;
		stop: chan of int;
	};
	Entrychan: adt {
		sync: chan of int;
		c: chan of Entry;
	};
	Cmpchan: type chan of (ref Sys->Dir, ref Sys->Dir, chan of int);
	Entry: type (ref Sys->Dir, string, int);
	Gatequery: type (Entry, chan of int);
	Gatechan: type chan of Gatequery;
	Fsdata: adt {
		dir: ref Sys->Dir;
		data: array of byte;
	};
	Fschan: type chan of (Fsdata, chan of int);
	Next, Down, Skip, Quit: con iota;
	Nilentry: con (nil, nil, 0);

};

Fsmodule: module {
	types: fn(): string;
	init:	fn();
	run: fn(ctxt: ref Draw->Context, r: ref Reports->Report,
		opts: list of Fs->Option, args: list of ref Fs->Value): ref Fs->Value;
};
Fsfilter: module {
	PATH: con "/dis/alphabet/fsfilter.dis";
	filter: fn[T](t: T, src, dst: Fs->Fschan)
		for{
		T =>
			query: fn(t: self T, d: ref Sys->Dir, name: string, depth: int): int;
		};
};

