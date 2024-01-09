// @deno-types="npm:@types/lodash.mapvalues"
import lodashMapValues from "npm:lodash.mapvalues@4.6.0";
import { mapEntries } from "https://deno.land/std@0.211.0/collections/mod.ts";
import { mapValues } from "https://raw.githubusercontent.com/ratson/deno_std/mapValues-transformer-key-param/collections/map_values.ts";

for (const size of [1, 10, 100, 1000, 10_000]) {
  const group = `size = ${size}`;
  const obj: Record<string, number> = {};
  for (let i = 0; i < size; i++) {
    obj[`${i}`] = 1;
  }

  Deno.bench({
    name: "mapValues",
    group,
    baseline: true,
    fn() {
      mapValues(obj, (v, k) => `${k} = ${v}`);
    },
  });

  Deno.bench({
    name: "mapEntries",
    group,
    fn() {
      mapEntries(obj, ([k, v]) => [k, `${k} = ${v}`]);
    },
  });

  Deno.bench({
    name: "Object.entries",
    group,
    fn() {
      Object.fromEntries(
        Object.entries(obj).map(([k, v]) => [k, `${k} = ${v}`]),
      );
    },
  });

  Deno.bench({
    name: "lodash.mapValues",
    group,
    fn() {
      lodashMapValues(obj, (v, k) => `${k} = ${v}`);
    },
  });
}
