import { BooleanLike } from 'common/react';
import { Box, Button, LabeledList } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

interface MicrowaveData {
  egg_amount: number;
  flour_amount: number;
  monkeymeat_amount: number;
  synthmeat_amount: number;
  donkpocket_amount: number;
  humanmeat_amount: number;
  extra_item: string;
  is_operating: BooleanLike;
  is_dirty: BooleanLike;
  is_broken: BooleanLike;
}

const Microwave = () => {
  const { data } = useBackend<MicrowaveData>();
  const {
    egg_amount,
    flour_amount,
    monkeymeat_amount,
    synthmeat_amount,
    donkpocket_amount,
    humanmeat_amount,
    extra_item,
    is_operating,
    is_dirty,
    is_broken,
  } = data;
  return (
    <Window>
      <Window.Content>
        {is_dirty && (
          <>
            <Box>Bzzzzttttt</Box>
            <Box>
              It&apos;s broken! It could be fixed with some common tools.
            </Box>
          </>
        )}
        {is_operating && (
          <>
            <Box>Microwaving in progress!</Box>
            <Box>Please wait...!</Box>
          </>
        )}
        {is_dirty && (
          <>
            <Box>This microwave is dirty!</Box>
            <Box>Please clean it before use!</Box>
          </>
        )}
        {!is_operating && !is_dirty && !is_broken && (
          <>
            <Box>Current Contents</Box>
            <LabeledList>
              <LabeledList.Item label="Eggs">{egg_amount}</LabeledList.Item>
              <LabeledList.Item label="Flour">{flour_amount}</LabeledList.Item>
              <LabeledList.Item label="Monkeymeat">
                {monkeymeat_amount}
              </LabeledList.Item>
              <LabeledList.Item label="Synthmeat">
                {synthmeat_amount}
              </LabeledList.Item>
              <LabeledList.Item label="Meat Turnovers">
                {donkpocket_amount}
              </LabeledList.Item>
              <LabeledList.Item label="Other Meat">
                {humanmeat_amount}
              </LabeledList.Item>
              <LabeledList.Item label="Unusual Item">
                {extra_item}
              </LabeledList.Item>
            </LabeledList>
            <Button>Turn on!</Button>
            <Button>Empty Contents!</Button>
          </>
        )}
      </Window.Content>
    </Window>
  );
};
