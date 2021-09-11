import React from 'react';
import { render } from '@testing-library/react';

import { Song, Track, Instrument } from '..';
import {
  mockChannelConstructor,
  // mockChannelVolume,
  // mockChannelPan,
  mockPolySynthDispose,
  mockSequenceConstructor,
  mockSequenceAdd,
  mockSequenceRemove,
  mockSequenceRemoveAll,
} from '../__mocks__/tone';

beforeEach(() => {
  jest.resetAllMocks();
});

describe('Track', () => {
  it('should render Track with steps, pan and volume props', () => {
    const { rerender } = render(
      <Song isPlaying={false} bpm={100}>
        <Track steps={['C3', null]} pan={2} volume={-6} mute={false}>
          <Instrument type="synth" />
        </Track>
      </Song>,
    );

    expect(mockChannelConstructor).toBeCalledWith(-6, 2);

    rerender(
      <Song isPlaying={true} bpm={100}>
        <Track
          steps={['C3', null, [{ name: 'C3' }, { name: 'G3' }], { name: 'E3' }]}
          pan={0}
          volume={0}
          mute={true}
        >
          <Instrument type="synth" />
        </Track>
      </Song>,
    );

    // TODO: Fix both of these, still getting called with original values
    // expect(mockChannelVolume).toBeCalledWith(0);
    // expect(mockChannelPan).toBeCalledWith(0);
    expect(mockSequenceConstructor).toBeCalledWith([
      { index: 0, notes: [{ name: 'C3' }] },
      { index: 1, notes: [] },
      { index: 2, notes: [{ name: 'C3' }, { name: 'G3' }] },
      { index: 3, notes: [{ name: 'E3' }] },
    ]);
  });

  it('should remove Track from song', () => {
    const { rerender } = render(
      <Song isPlaying={true}>
        <Track steps={['C3']}>
          <Instrument type="synth" />
        </Track>
      </Song>,
    );

    expect(mockChannelConstructor).toBeCalledWith(0, 0);
    expect(mockPolySynthDispose).toBeCalledTimes(0);

    // @ts-ignore
    rerender(<Song isPlaying={true}></Song>);

    expect(mockPolySynthDispose).toBeCalledTimes(1);
  });

  it('should add and remove steps from sequencer', () => {
    const { rerender } = render(
      <Song isPlaying={true}>
        <Track steps={['C3']}>
          <Instrument type="synth" />
        </Track>
      </Song>,
    );

    rerender(
      <Song isPlaying={true}>
        <Track steps={['C3', 'D3']}>
          <Instrument type="synth" />
        </Track>
      </Song>,
    );

    expect(mockSequenceAdd).toHaveBeenLastCalledWith(1, {
      index: 1,
      notes: [{ name: 'D3' }],
    });

    rerender(
      <Song isPlaying={true}>
        <Track steps={['C3', 'D3', [{ name: 'C3' }]]}>
          <Instrument type="synth" />
        </Track>
      </Song>,
    );

    expect(mockSequenceAdd).toHaveBeenLastCalledWith(2, {
      index: 2,
      notes: [{ name: 'C3' }],
    });

    rerender(
      <Song isPlaying={true}>
        <Track steps={['C3', null, [{ name: 'C3' }]]}>
          <Instrument type="synth" />
        </Track>
      </Song>,
    );

    expect(mockSequenceRemove).toHaveBeenLastCalledWith(1);

    rerender(
      <Song isPlaying={true}>
        <Track steps={['C3', null]}>
          <Instrument type="synth" />
        </Track>
      </Song>,
    );

    expect(mockSequenceRemoveAll).toHaveBeenLastCalledWith();
    expect(mockSequenceAdd).toHaveBeenCalledWith(0, {
      index: 0,
      notes: [{ name: 'C3' }],
    });
    expect(mockSequenceAdd).toHaveBeenCalledWith(1, {
      index: 1,
      notes: [],
    });
  });
});
