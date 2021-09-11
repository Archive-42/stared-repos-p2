import React from 'react';
import { render } from '@testing-library/react';
import Tone from 'tone';

import { Song, Track, Instrument, Effect } from '..';
import {
  mockAutoFilterConstructor,
  mockAutoPannerConstructor,
  mockPolySynthChain,
  mockChannelConstructor,
} from '../__mocks__/tone';

beforeEach(() => {
  jest.resetAllMocks();
});

describe('Effect', () => {
  // TODO: Fix theses tests after upgrading Tone JS to v14
  xit('should add and remove effects from Instrument', () => {
    const { rerender } = render(
      <Song isPlaying={true}>
        <Track
          steps={['C3']}
          // TODO: Remove need for key and id prop
          // effects={}
        >
          <Instrument type="synth" />
          <Effect type="autoFilter" id="effect-1" />
        </Track>
      </Song>,
    );

    expect(mockAutoFilterConstructor).toBeCalled();
    expect(mockPolySynthChain).toHaveBeenLastCalledWith(
      { id: 'effect-1', wet: { value: 1 } },
      {
        dispose: mockChannelConstructor,
        mute: undefined,
        solo: undefined,
        pan: { value: 0 },
        volume: { value: 0 },
      },
      Tone.Master,
    );

    rerender(
      <Song isPlaying={true}>
        <Track
          steps={['C3']}
          // effects={
          //   <>
          //     <Effect type="autoFilter" id="effect-1" />
          //     <Effect type="autoPanner" id="effect-2" />
          //   </>
          // }
        >
          <Instrument type="synth" />
          <Effect type="autoFilter" id="effect-1" />
          <Effect type="autoPanner" id="effect-2" />
        </Track>
      </Song>,
    );

    expect(mockAutoPannerConstructor).toBeCalled();
    expect(mockPolySynthChain).toHaveBeenLastCalledWith(
      { id: 'effect-2' },
      { id: 'effect-1', wet: { value: 1 } },
      { pan: { value: 0 }, volume: { value: 0 } },
      Tone.Master,
    );

    rerender(
      <Song isPlaying={true}>
        <Track
          steps={['C3']}
          // effects={
          //   <>
          //     <Effect type="autoPanner" id="effect-2" />
          //   </>
          // }
        >
          <Instrument type="synth" />
          <Effect type="autoPanner" id="effect-2" />
        </Track>
      </Song>,
    );

    expect(mockPolySynthChain).toHaveBeenLastCalledWith(
      { id: 'effect-2' },
      { pan: { value: 0 }, volume: { value: 0 } },
      Tone.Master,
    );

    rerender(
      <Song isPlaying={true}>
        <Track steps={['C3']} effects={null}>
          <Instrument type="synth" />
        </Track>
      </Song>,
    );

    expect(mockPolySynthChain).toHaveBeenLastCalledWith(
      {
        pan: { value: 0 },
        volume: { value: 0 },
      },
      Tone.Master,
    );
  });

  // TODO: Fix these tests after upgrading Tone JS to v14
  xit('should update wet prop', () => {
    render(
      <Song isPlaying={true}>
        <Track steps={['C3']}>
          <Instrument type="synth" />
          <Effect type="autoFilter" id="effect-1" wet={0.5}></Effect>
        </Track>
      </Song>,
    );

    expect(mockPolySynthChain).toHaveBeenLastCalledWith(
      { id: 'effect-1', wet: { value: 0.5 } },
      { pan: { value: 0 }, volume: { value: 0 } },
      Tone.Master,
    );
  });

  // TODO: Fix these tests after upgrading Tone JS to v14
  xit('should add EQ3 effect and then update frequency', () => {
    const { rerender } = render(
      <Song isPlaying={true}>
        <Track steps={['C3']}>
          <Instrument type="synth" />
          <Effect type="eq3" id="effect-1" low={-6} mid={3} high={1} />
        </Track>
      </Song>,
    );

    expect(mockPolySynthChain).toHaveBeenLastCalledWith(
      {
        id: 'effect-1',
        low: { value: -6 },
        mid: { value: 3 },
        high: { value: 1 },
        lowFrequency: { value: 400 },
        highFrequency: { value: 2500 },
      },
      { pan: { value: 0 }, volume: { value: 0 } },
      Tone.Master,
    );

    rerender(
      <Song isPlaying={true}>
        <Track steps={['C3']}>
          <Instrument type="synth" />
          <Effect
            type="eq3"
            id="effect-1"
            low={-3}
            mid={1}
            high={0}
            lowFrequency={100}
            highFrequency={3000}
          />
        </Track>
      </Song>,
    );

    expect(mockPolySynthChain).toHaveBeenLastCalledWith(
      {
        id: 'effect-1',
        low: { value: -3 },
        mid: { value: 1 },
        high: { value: 0 },
        lowFrequency: { value: 100 },
        highFrequency: { value: 3000 },
      },
      { pan: { value: 0 }, volume: { value: 0 } },
      Tone.Master,
    );
  });
});
