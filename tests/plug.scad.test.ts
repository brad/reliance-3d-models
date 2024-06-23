import {
  ThreeDModule,
  TwoDModule
} from '@bradpitcher/unittestscad';

describe("Plug", () => {
  it.each([
    [{}, [12.1, 12.1, 35.4]],
    [{d: '[14, 11.5, 7.6, 7.2, 6.3, 6]'}, [14, 14, 35.4]],
    [{h: '[2.6, 6.4, 6.4, 2.4, 13, 5.2]'}, [12.1, 12.1, 36]],
    [{d: '[14, 11.5, 7.6, 7.2, 6.3, 6]', original: true}, [14, 14, 35.4]],
    [{h: '[2.6, 6.4, 6.4, 2.4, 13, 5.2]', original: true}, [12.1, 12.1, 36]],
  ])(
    "should have the correct dimensions with vars: %o",
    (vars: any, dims: number[]) => {
      const plug = new ThreeDModule({
        openSCADDirectory: 'src',
        include: ["plug.scad"],
        variables: { $fn: '50', ...vars },
      });

      expect(plug.width).toBeCloseTo(dims[0], 1);
      expect(plug.depth).toBeCloseTo(dims[1], 1);
      expect(plug.height).toBeCloseTo(dims[2], 1);
    }
  );

  it.each([
    [false, 0, [14, 14]],
    [false, -2.59, [11.5, 11.5]],
    [false, -2.61, [7.6, 7.6]],
    [false, -8.99, [7.2, 7.2]],
    [false, -9.01, [6.3, 6.3]],
    [false, -15.39, [6, 6]],
    [false, -15.41, [6, 6]],
    [false, -17.8, [5.5, 5.5]],
    [false, -30.79, [3, 3]],
    [false, -30.81, [9, 3]],
    [true, 0, [14, 14]],
    [true, -2.59, [11.5, 11.5]],
    [true, -2.61, [7.6, 7.6]],
    [true, -8.99, [7.2, 7.2]],
    [true, -9.01, [6.3, 6.3]],
    [true, -15.39, [6, 6]],
    [true, -15.41, [6, 6]],
    [true, -17.8, [3, 2]],
    [true, -30.79, [3, 2]],
    [true, -30.81, [9, 2]],
  ])(
    "2d projection should have the correct dimensions with original: %s, z: %s",
    (original: boolean, z: number, dims: number[]) => {
      const varsDict = {
        d: '[14, 11.5, 7.6, 7.2, 6.3, 6]',
        h: '[2.6, 6.4, 6.4, 2.4, 13, 5.2]',
        stem: '[3, 2, 9]',
        $fn: 50,
        original,
      };
      const vars = Object.entries(varsDict)
        .map(([key, value]) => `${key}=${value}`)
        .join(', ');
      const translate = `translate([0, 0, ${z}])`;
      const plug = new TwoDModule({
        openSCADDirectory: 'src',
        use: ['plug.scad'],
        testText: `projection(cut=true) ${translate} plug(${vars});`,
      });

      expect(plug.width).toBeCloseTo(dims[0], 1);
      expect(plug.height).toBeCloseTo(dims[1], 1);
    }
  );
});
