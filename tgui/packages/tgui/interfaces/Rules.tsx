import { useBackend } from "../backend";
import { Box, Divider, Section } from "../components";
import { Window } from "../layouts";

interface RulesData {
  title: string;
  header: string;
  preamble: string;
  rule_list: RuleProps[]
}

interface RuleProps {
  rule: string,
  explainer: string,
}

export const Rules = (props, context) => {
  const { data } = useBackend<RulesData>(context);
  const { title, header, preamble, rule_list } = data;
  return (
    <Window
      title={title}
      width={420}
      height={370}>
      <Window.Content >
        <Section title={header} textAlign="center">
          <Box textAlign="left" dangerouslySetInnerHTML={{ __html: preamble }} />
          <Divider />
          <ol>
            {
              rule_list.map((rule, index) => {
                return (
                  <Rule key={index} {...rule} />
                );
              })
            }
          </ol>
        </Section>
      </Window.Content>
    </Window>
  );
};

const Rule = (props: RuleProps) => {
  const { rule, explainer } = props;
  return (
    <li>
      <Section textAlign="left" title={rule} mr={5} >
        <Box textAlign="left" dangerouslySetInnerHTML={{ __html: explainer }} />
      </Section>
    </li>
  );
};
