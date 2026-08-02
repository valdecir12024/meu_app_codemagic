import 'escala_mchat.dart';
import 'escala_cars.dart';
import 'escala_abc.dart';
import 'escala_asrs18_rastreio.dart';
import 'escala_ata.dart';
import 'escala_atencao_visual.dart';
import 'escala_memoria_curto_prazo.dart';
import 'escala_snap_completa.dart';
import 'escala_conners.dart';
import 'escala_vanderbilt.dart';
import 'escala_basic3.dart';
import 'escala_icu.dart';
import 'escala_cries13.dart';
import 'escala_iat.dart';
import 'escala_mbi.dart';
import 'escala_cfq.dart';
import 'escala_erg.dart';
import 'escala_msibpd.dart';
import 'escala_crafft.dart';
import 'escala_bullying.dart';
import 'escala_bigfive.dart';
import 'escala_sdq.dart';
import 'escala_scared.dart';
import 'escala_rosemberg.dart';
import 'escala_hads.dart';
import 'escala_gifts.dart';
import 'escala_dislexia_infantil.dart';
import 'escala_eat.dart';
import 'escala_igi.dart';
import 'escala_mdq.dart';
import 'escala_erotomaniaca_infantil.dart';
import 'escala_discalculia.dart';
import 'escala_asrs_adulta.dart';
import 'escala_dislexia_adulto.dart';
import 'escala_aq10.dart';
import 'escala_freudenberger.dart';
import 'escala_beck.dart';
import 'escala_tas20.dart';
import 'escala_catq.dart';
import 'escala_aq50.dart';
import 'escala_gqasc.dart';
import 'escala_srs2.dart';
import 'escala_spm2.dart';
import 'escala_raadsr.dart';
import 'escala_whodas.dart';
import 'escala_erotomaniaca_adulta.dart';

class BancoPerguntas {
  /// Buscador dinâmico que direciona a tela para a gaveta de perguntas correta das 4 abas
  static List<String> obterPerguntas(String nomeDoTeste) {
    final teste = nomeDoTeste.trim().toLowerCase();

    // =========================================================================
    // ABA 1: NEURO
    // =========================================================================
    if (teste.contains('m-chat')) return EscalaMchat.perguntas;
    if (teste.contains('cars')) return EscalaCars.perguntas;
    if (teste.contains('abc')) return EscalaAbc.perguntas;
    if (teste.contains('asrs-18 (rastreio') || (teste.contains('asrs-18') && !teste.contains('completa'))) {
      return EscalaAsrs18Rastreio.perguntas;
    }
    if (teste.contains('ata')) return EscalaAta.perguntas;
    if (teste.contains('atenção visual')) return EscalaAtencaoVisual.perguntas;
    if (teste.contains('memória')) return EscalaMemoriaCurtoPrazo.perguntas;

    // =========================================================================
    // ABA 2: COMPORTAMENTO
    // =========================================================================
    if (teste.contains('snap')) return EscalaSnapCompleta.perguntas;
    if (teste.contains('conners')) return EscalaConners.perguntas;
    if (teste.contains('vanderbilt')) return EscalaVanderbilt.perguntas;
    if (teste.contains('basic 3')) return EscalaBasic3.perguntas;
    if (teste.contains('icu')) return EscalaIcu.perguntas;
    if (teste.contains('cries-13') || teste.contains('cries')) return EscalaCries13.perguntas;
    if (teste.contains('iat') || teste.contains('internet')) return EscalaIat.perguntas;
    if (teste.contains('mbi') || teste.contains('burnout acadêmico')) return EscalaMbi.perguntas;
    if (teste.contains('cfq')) return EscalaCfq.perguntas;
    if (teste.contains('erg')) return EscalaErg.perguntas;
    if (teste.contains('msi-bpd') || teste.contains('msi')) return EscalaMsibpd.perguntas;
    if (teste.contains('crafft')) return EscalaCrafft.perguntas;
    if (teste.contains('vitimização') || teste.contains('bullying')) return EscalaBullying.perguntas;
    if (teste.contains('big five') || teste.contains('personalidade')) return EscalaBigFive.perguntas;

    // =========================================================================
    // ABA 3: SOCIOEMOCIONAL
    // =========================================================================
    if (teste.contains('sdq')) return EscalaSdq.perguntas;
    if (teste.contains('scared')) return EscalaScared.perguntas;
    if (teste.contains('rosemberg')) return EscalaRosemberg.perguntas;
    if (teste.contains('hads')) return EscalaHads.perguntas;
    if (teste.contains('gifts')) return EscalaGifts.perguntas;
    if (teste.contains('dislexia') && !teste.contains('adulto')) return EscalaDislexiaInfantil.perguntas;
    if (teste.contains('eat')) return EscalaEat.perguntas;
    if (teste.contains('igi')) return EscalaIgi.perguntas;
    if (teste.contains('mdq')) return EscalaMdq.perguntas;
    if (teste.contains('erotomaníaca') && !teste.contains('adulto')) return EscalaErotomaniacaInfantil.perguntas;
    if (teste.contains('discalculia')) return EscalaDiscalculia.perguntas;

    // =========================================================================
    // ABA 4: ADULTO / EJA
    // =========================================================================
    if (teste.contains('asrs-18 completa') || teste.contains('asrs adulto')) return EscalaAsrsAdulta.perguntas;
    if (teste.contains('dislexia adulto')) return EscalaDislexiaAdulto.perguntas;
    if (teste.contains('aq-10')) return EscalaAq10.perguntas;
    if (teste.contains('freudenberger')) return EscalaFreudenberger.perguntas;
    if (teste.contains('beck') || teste.contains('bdi')) return EscalaBeck.perguntas;
    if (teste.contains('tas-20') || teste.contains('alexitimia')) return EscalaTas20.perguntas;
    if (teste.contains('cat-q') || teste.contains('camuflagem')) return EscalaCatq.perguntas;
    if (teste.contains('aq-50')) return EscalaAq50.perguntas;
    if (teste.contains('gq-asc')) return EscalaGqasc.perguntas;
    if (teste.contains('srs-2')) return EscalaSrs2.perguntas;
    if (teste.contains('spm-2')) return EscalaSpm2.perguntas;
    if (teste.contains('raads-r')) return EscalaRaadsr.perguntas;
    if (teste.contains('whodas 2.0')) return EscalaWhodas.perguntas;
    if (teste.contains('ideação erotomaníaca') && teste.contains('adulto')) return EscalaErotomaniacaAdulta.perguntas;

    // Escudo de contingência absoluto de segurança
    return [
      '1. Apresenta indicadores de comportamento atípico observados na rotina diária?',
      '2. Manifesta necessidade de acompanhamento ou triagem preventiva complementar?',
      '3. Os sinais reportados geram impacto direto na funcionalidade e bem-estar do indivíduo?',
    ];
  }
}
