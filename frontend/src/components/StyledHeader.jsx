import styled from 'styled-components';
import { LocalMallIcon } from '../components/Icons';
import { COLORS } from '../style_constants';

export const HeaderWrapper = styled.div`
  display: flex;
  justify-content: space-between;
  padding: 8px 32px;
`;

export const MainLogoImage = styled.img`
  height: 90px;
`

export const BagIconWrapper = styled.div`
  padding-top: 24px;
`;

export const ColoredBagIcon = styled(LocalMallIcon)`
  color: ${COLORS.MAIN};
`;
