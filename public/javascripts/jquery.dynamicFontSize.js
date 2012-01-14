/*! http://code.google.com/p/jqdynamicfontsize */
/*
  extend jQuery with a method to dynamically adjust the font size to fit the
  provided number of lines. This plugin is licensed under the MIT license.

  Options:
   * squeezeFactor - The factor to attempt to squeeze for each step (0.1 as default)
   * tries - The maximum attempt of squeezing attempts before giving up (3 as default)
   * lines - The number of lines to try to fit the text to (1 as default)
   * limitWidth - Calculates font-size based on the width of the container (false as default)
   * allowUpscaling - Allows the width-based scaler to make the text bigger (false as default)

  http://code.google.com/p/jqdynamicfontsize

  2009-03-06 Initial version * Mats Lindh <mats [a] gamer.no>
  2009-03-19 Make sure the element is a block element * Peter Haza <ph [a] budstikka.no>
  2009-03-19 Fix bug related to giving the function several elements at once * Peter Haza <ph [a] budstikka.no>
  2009-03-19 Fixed proper jQuery option handling * Mats Lindh <mats [a] gamer.no>
  2009-03-20 Make provided options override default instead of the opposite * Peter Haza <ph [a] budstikka.no>
  2009-04-02 Allows resizing by the width of the available container * Vegard Andreas Larsen <vegard [a] prove.no>
*/
jQuery.fn.dynamicFontSize = function(providedOptions)
{
    var opts = $.extend(jQuery.fn.dynamicFontSize.defaults, providedOptions);

    return this.each(function()
    {
        var jQel = $(this);
        var dType = jQel.css('display');
        jQel.css('display', 'block');
        var fSize = jQel.css('font-size');
        fSize = fSize.substring(0, fSize.length-2);
        var newSize = fSize;
        var bestMatch = newSize;
        var bestMatchHeight = jQel.height();
        var lLines = opts.lines + 0.6;

        if (jQel.height() > (fSize * lLines))
        {
            for (i = 0; i < opts.tries; i++)
            {
                newSize -= (fSize * opts.squeezeFactor);
                jQel.css('font-size', newSize + 'px');

                if (jQel.height() < bestMatchHeight)
                {
                    bestMatchHeight = jQel.height();
                    bestMatch = newSize;
                }

                if (jQel.height() < (fSize * lLines))
                {
                    bestMatchHeight = 0;
                    bestMatch = 0;

                    break;
                }
            }

            if (bestMatchHeight && bestMatch)
            {
                jQel.css('font-size', bestMatch + 'px');
            }
        }

        if (opts.limitWidth)
        {
            // The width of the element while display: block is set, is the
            // same as the width the text wants to be
            var blockWidth = jQel.width();

            // Make the element reflow to fill the entire container.
            jQel.css('display', 'inline');
            cssWidth = jQel.css('width');
            jQel.css('width', 'auto');

            // Calculate new font size
            var newSize = (fSize * blockWidth) / jQel.innerWidth();

            if (newSize < fSize || opts.allowUpscaling)
            {
                jQel.css('font-size', newSize + 'px');
            }

            jQel.css('width', cssWidth);
        }

        jQel.css('display', dType);
    });
};

jQuery.fn.dynamicFontSize.defaults = {squeezeFactor: 0.1, tries: 5, lines: 1, limitWidth: false, allowUpscaling: false};