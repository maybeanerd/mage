package mage.cards.s;

import mage.abilities.dynamicvalue.common.ManacostVariableValue;
import mage.abilities.effects.common.CreateTokenEffect;
import mage.cards.CardImpl;
import mage.cards.CardSetInfo;
import mage.constants.CardType;
import mage.game.permanent.token.RatCantBlockToken;

import java.util.UUID;

/**
 * @author Susucr
 */
public final class SongOfTotentanz extends CardImpl {

    public SongOfTotentanz(UUID ownerId, CardSetInfo setInfo) {
        super(ownerId, setInfo, new CardType[]{CardType.SORCERY}, "{X}{R}");

        // Create X 1/1 black Rat creature tokens with “This creature can’t block.” Creatures you control gain haste until end of turn.
        this.getSpellAbility().addEffect(new CreateTokenEffect(new RatCantBlockToken(), ManacostVariableValue.REGULAR));
    }

    private SongOfTotentanz(final SongOfTotentanz card) {
        super(card);
    }

    @Override
    public SongOfTotentanz copy() {
        return new SongOfTotentanz(this);
    }
}
